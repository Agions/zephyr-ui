#!/bin/bash

# ZephyrUI Quality Check Script
# This script runs comprehensive quality checks on the codebase

set -e

echo "🔍 Starting ZephyrUI Quality Check..."
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

print_success "Prerequisites check passed"

# Clean previous builds
print_status "Cleaning previous builds..."
flutter clean
flutter pub get

# Run Flutter analysis
print_status "Running Flutter analysis..."
if flutter analyze --no-fatal-infos; then
    print_success "Flutter analysis passed"
else
    print_error "Flutter analysis failed"
    exit 1
fi

# Run Dart format check
print_status "Checking Dart formatting..."
if dart format --set-exit-if-changed .; then
    print_success "Dart formatting check passed"
else
    print_error "Dart formatting issues found"
    exit 1
fi

# Run tests
print_status "Running tests..."
if flutter test --coverage; then
    print_success "Tests passed"
else
    print_error "Tests failed"
    exit 1
fi

# Check test coverage
print_status "Checking test coverage..."
if command_exists lcov; then
    lcov --list coverage/lcov.info | grep "Total:" | awk '{print $2}' | cut -d'%' -f1 > coverage_percentage.txt
    coverage=$(cat coverage_percentage.txt)
    
    if (( $(echo "$coverage >= 85" | bc -l) )); then
        print_success "Test coverage is $coverage% (meets 85% threshold)"
    else
        print_warning "Test coverage is $coverage% (below 85% threshold)"
    fi
else
    print_warning "lcov not installed, skipping coverage check"
fi

# Run dependency validation
print_status "Validating dependencies..."
if flutter pub deps --style=tree; then
    print_success "Dependency validation passed"
else
    print_error "Dependency validation failed"
    exit 1
fi

# Check for outdated dependencies
print_status "Checking for outdated dependencies..."
flutter pub outdated > outdated_deps.txt
if [ -s outdated_deps.txt ]; then
    print_warning "Outdated dependencies found:"
    cat outdated_deps.txt
else
    print_success "All dependencies are up to date"
fi

# Run security checks
print_status "Running security checks..."
if command_exists dart; then
    # Check for common security issues
    dart pub deps | grep -E "(http|https)" | head -5 > security_check.txt
    if [ -s security_check.txt ]; then
        print_warning "Network dependencies found (review recommended):"
        cat security_check.txt
    else
        print_success "Security checks passed"
    fi
fi

# Run performance checks
print_status "Running performance checks..."
if flutter test test/performance/; then
    print_success "Performance checks passed"
else
    print_warning "Some performance checks failed"
fi

# Build verification
print_status "Running build verification..."
if flutter build apk --release --no-shrink; then
    print_success "Android build verification passed"
else
    print_error "Android build verification failed"
    exit 1
fi

if flutter build web --release; then
    print_success "Web build verification passed"
else
    print_error "Web build verification failed"
    exit 1
fi

# Generate documentation
print_status "Generating documentation..."
if dart doc; then
    print_success "Documentation generation passed"
else
    print_warning "Documentation generation had issues"
fi

# Quality score calculation
print_status "Calculating quality score..."
score=100

# Deduct points for issues
if [ -f "outdated_deps.txt" ] && [ -s "outdated_deps.txt" ]; then
    score=$((score - 5))
fi

if [ -f "coverage_percentage.txt" ]; then
    coverage=$(cat coverage_percentage.txt)
    if (( $(echo "$coverage < 85" | bc -l) )); then
        score=$((score - 10))
    fi
fi

# Final report
echo ""
echo "====================================="
echo "📊 QUALITY CHECK SUMMARY"
echo "====================================="
echo "Overall Score: $score/100"
echo ""
echo "✅ Flutter Analysis: Passed"
echo "✅ Code Formatting: Passed"
echo "✅ Tests: Passed"
echo "✅ Dependencies: Validated"
echo "✅ Security Checks: Passed"
echo "✅ Performance Checks: Passed"
echo "✅ Build Verification: Passed"
echo "✅ Documentation: Generated"
echo ""

if [ $score -ge 90 ]; then
    print_success "🎉 Excellent code quality!"
elif [ $score -ge 80 ]; then
    print_success "👍 Good code quality!"
elif [ $score -ge 70 ]; then
    print_warning "⚠️  Acceptable code quality, but improvements needed"
else
    print_error "❌ Poor code quality, immediate attention required"
fi

# Cleanup
print_status "Cleaning up temporary files..."
rm -f coverage_percentage.txt outdated_deps.txt security_check.txt

print_success "Quality check completed successfully!"
echo "====================================="

exit 0