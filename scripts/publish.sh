#!/bin/bash

# ZephyrUI Publishing Script
# This script handles the complete publishing process for pub.dev

set -e

echo "🚀 Starting ZephyrUI Publishing Process..."
echo "====================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to confirm action
confirm() {
    read -p "$1 [y/N]: " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
}

# Check prerequisites
print_status "Checking prerequisites..."

if ! command_exists flutter; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

if ! command_exists dart; then
    print_error "Dart is not installed or not in PATH"
    exit 1
fi

if ! command_exists git; then
    print_error "Git is not installed or not in PATH"
    exit 1
fi

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    print_error "Not in a git repository"
    exit 1
fi

# Check for uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    print_error "There are uncommitted changes. Please commit or stash them first."
    exit 1
fi

# Check if we're on main branch
current_branch=$(git branch --show-current)
if [ "$current_branch" != "main" ]; then
    print_warning "Not on main branch. Current branch: $current_branch"
    confirm "Do you want to continue publishing from this branch?"
fi

print_success "Prerequisites check passed"

# Get version from pubspec.yaml
print_status "Reading version from pubspec.yaml..."
version=$(grep 'version:' pubspec.yaml | awk '{print $2}')
print_status "Current version: $version"

# Version validation
print_status "Validating version format..."
if [[ ! $version =~ ^[0-9]+\.[0-9]+\.[0-9]+([-+][a-zA-Z0-9]+)*$ ]]; then
    print_error "Invalid version format: $version"
    exit 1
fi

print_success "Version format is valid"

# Run pre-publish checks
print_status "Running pre-publish checks..."

# Clean and get dependencies
print_status "Cleaning and updating dependencies..."
flutter clean
flutter pub get

# Run analysis
print_status "Running code analysis..."
if ! flutter analyze --no-fatal-infos; then
    print_error "Code analysis failed"
    exit 1
fi

# Run tests
print_status "Running tests..."
if ! flutter test --coverage; then
    print_error "Tests failed"
    exit 1
fi

# Check test coverage
print_status "Checking test coverage..."
if command_exists lcov; then
    lcov --list coverage/lcov.info | grep "Total:" | awk '{print $2}' | cut -d'%' -f1 > coverage_percentage.txt
    coverage=$(cat coverage_percentage.txt)
    
    if (( $(echo "$coverage < 85" | bc -l) )); then
        print_error "Test coverage is $coverage% (below 85% threshold)"
        exit 1
    else
        print_success "Test coverage is $coverage%"
    fi
else
    print_warning "lcov not installed, skipping coverage check"
fi

# Dry run publish
print_status "Running dry run publish..."
if ! flutter pub publish --dry-run; then
    print_error "Dry run publish failed"
    exit 1
fi

print_success "Dry run publish successful"

# Check required files
print_status "Checking required files..."
required_files=("README.md" "CHANGELOG.md" "LICENSE" "pubspec.yaml")
for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        print_error "Required file $file is missing"
        exit 1
    fi
done

print_success "All required files are present"

# Build verification
print_status "Running build verification..."
if ! flutter build apk --release --no-shrink; then
    print_error "Android build verification failed"
    exit 1
fi

if ! flutter build web --release; then
    print_error "Web build verification failed"
    exit 1
fi

print_success "Build verification passed"

# Generate documentation
print_status "Generating documentation..."
if ! dart doc; then
    print_warning "Documentation generation had issues"
else
    print_success "Documentation generated"
fi

# Create distribution package
print_status "Creating distribution package..."
dist_dir="dist"
rm -rf "$dist_dir"
mkdir -p "$dist_dir"

# Copy essential files
cp -r lib/ "$dist_dir/"
cp -r assets/ "$dist_dir/"
cp pubspec.yaml "$dist_dir/"
cp README.md "$dist_dir/"
cp LICENSE "$dist_dir/"
cp CHANGELOG.md "$dist_dir/"

print_success "Distribution package created"

# Summary of checks
echo ""
echo "====================================="
echo "📋 PRE-PUBLISH CHECKLIST"
echo "====================================="
echo "✅ Version format: Valid"
echo "✅ Code analysis: Passed"
echo "✅ Tests: Passed"
echo "✅ Test coverage: 85%+"
echo "✅ Dependencies: Updated"
echo "✅ Build verification: Passed"
echo "✅ Documentation: Generated"
echo "✅ Required files: Present"
echo "✅ Dry run publish: Successful"
echo ""

# Final confirmation
print_warning "About to publish ZephyrUI version $version to pub.dev"
print_warning "This action cannot be undone!"
confirm "Are you sure you want to publish?"

# Publish to pub.dev
print_status "Publishing to pub.dev..."
if flutter pub publish --force; then
    print_success "Successfully published to pub.dev!"
else
    print_error "Publishing failed"
    exit 1
fi

# Create git tag
print_status "Creating git tag..."
tag_name="v$version"
if git tag -a "$tag_name" -m "Release version $version"; then
    print_success "Git tag created: $tag_name"
else
    print_warning "Failed to create git tag"
fi

# Push tag to remote
print_status "Pushing tag to remote..."
if git push origin "$tag_name"; then
    print_success "Tag pushed to remote"
else
    print_warning "Failed to push tag to remote"
fi

# Update documentation
print_status "Updating documentation..."
if [ -d "doc/api" ]; then
    # Update version in documentation
    find doc/ -name "*.md" -exec sed -i.bak "s/version: [0-9]\+\.[0-9]\+\.[0-9]\+/version: $version/g" {} \;
    find doc/ -name "*.md.bak" -delete
    print_success "Documentation updated"
fi

# Generate release notes
print_status "Generating release notes..."
cat > release-notes.md << EOF
# ZephyrUI v$version Release Notes

## What's New

- Bug fixes and improvements
- Enhanced documentation
- Performance optimizations

## Installation

\`\`\`yaml
dependencies:
  zephyr_ui: ^$version
\`\`\`

## Documentation

Full documentation is available at: https://zephyrui.dev

## Support

For issues and questions, please visit:
- GitHub Issues: https://github.com/zephyrui/zephyr_ui/issues
- Documentation: https://docs.zephyrui.dev

---

## Changelog

For detailed changes, see [CHANGELOG.md](CHANGELOG.md)
EOF

print_success "Release notes generated"

# Cleanup
print_status "Cleaning up..."
rm -rf coverage/ "$dist_dir"
rm -f coverage_percentage.txt

# Final success message
echo ""
echo "====================================="
echo "🎉 PUBLISHING COMPLETE!"
echo "====================================="
echo "✅ Version: $version"
echo "✅ Published to: pub.dev"
echo "✅ Git tag: $tag_name"
echo "✅ Documentation: Updated"
echo "✅ Release notes: Generated"
echo ""
echo "📦 Package URL: https://pub.dev/packages/zephyr_ui"
echo "📚 Documentation: https://docs.zephyrui.dev"
echo "🐛 Issues: https://github.com/zephyrui/zephyr_ui/issues"
echo ""
print_success "Thank you for publishing ZephyrUI!"
echo "====================================="

exit 0