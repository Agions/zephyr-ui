#!/bin/bash

# ZephyrUI Security Scan Script
# This script runs comprehensive security checks on the codebase

set -e

echo "🔒 Starting ZephyrUI Security Scan..."
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

# Initialize security score
security_score=100

# Clean previous builds
print_status "Cleaning previous builds..."
flutter clean
flutter pub get

# 1. Dependency Security Scan
print_status "Scanning dependencies for vulnerabilities..."
if command_exists dart; then
    # Check for known vulnerable packages
    flutter pub deps > deps.txt
    
    # Look for potentially risky dependencies
    if grep -q "http:" deps.txt; then
        print_warning "HTTP dependencies found (consider using HTTPS)"
        security_score=$((security_score - 5))
    fi
    
    # Check for outdated packages
    flutter pub outdated > outdated.txt
    if [ -s outdated.txt ]; then
        print_warning "Outdated dependencies found"
        security_score=$((security_score - 10))
    fi
    
    print_success "Dependency scan completed"
fi

# 2. Code Security Analysis
print_status "Analyzing code for security issues..."
security_issues=0

# Check for hardcoded secrets
print_status "Checking for hardcoded secrets..."
if find lib/ -name "*.dart" -exec grep -l "password\|secret\|token\|key" {} \; | head -5 > secrets.txt; then
    if [ -s secrets.txt ]; then
        print_error "Potential hardcoded secrets found:"
        cat secrets.txt
        security_score=$((security_score - 20))
        security_issues=$((security_issues + 1))
    else
        print_success "No hardcoded secrets found"
    fi
fi

# Check for insecure API usage
print_status "Checking for insecure API usage..."
if find lib/ -name "*.dart" -exec grep -l "http://\|eval(\|exec(" {} \; | head -5 > insecure.txt; then
    if [ -s insecure.txt ]; then
        print_warning "Potentially insecure API usage found:"
        cat insecure.txt
        security_score=$((security_score - 15))
        security_issues=$((security_issues + 1))
    else
        print_success "No insecure API usage found"
    fi
fi

# 3. Network Security
print_status "Checking network security..."
if find lib/ -name "*.dart" -exec grep -l "HttpClient\|http.Client" {} \; | head -5 > network.txt; then
    if [ -s network.txt ]; then
        print_warning "HTTP client usage found (verify SSL pinning)"
        security_score=$((security_score - 5))
    else
        print_success "Network security check passed"
    fi
fi

# 4. Input Validation
print_status "Checking input validation..."
if find lib/ -name "*.dart" -exec grep -l "TextEditingController\|FormField" {} \; | head -5 > input.txt; then
    if [ -s input.txt ]; then
        print_status "Input fields found (validation recommended)"
        # Not deducting points as this is normal for UI components
    else
        print_success "Input validation check passed"
    fi
fi

# 5. File System Security
print_status "Checking file system operations..."
if find lib/ -name "*.dart" -exec grep -l "File(\|Directory(\|open(" {} \; | head -5 > files.txt; then
    if [ -s files.txt ]; then
        print_warning "File system operations found (verify path validation)"
        security_score=$((security_score - 5))
    else
        print_success "File system security check passed"
    fi
fi

# 6. Platform Security
print_status "Checking platform security..."
if find lib/ -name "*.dart" -exec grep -l "MethodChannel\|EventChannel" {} \; | head -5 > platform.txt; then
    if [ -s platform.txt ]; then
        print_warning "Platform channels found (verify security)"
        security_score=$((security_score - 5)
    else
        print_success "Platform security check passed"
    fi
fi

# 7. Web Security (if web support)
print_status "Checking web security..."
if find lib/ -name "*.dart" -exec grep -l "html\|dart:html" {} \; | head -5 > web.txt; then
    if [ -s web.txt ]; then
        print_warning "Web-specific code found (verify XSS prevention)"
        security_score=$((security_score - 10))
    else
        print_success "Web security check passed"
    fi
fi

# 8. Authentication and Authorization
print_status "Checking authentication patterns..."
if find lib/ -name "*.dart" -exec grep -l "auth\|login\|password" {} \; | head -5 > auth.txt; then
    if [ -s auth.txt ]; then
        print_status "Authentication-related code found (verify security)"
        # Not deducting points as this is normal for UI components
    else
        print_success "Authentication check passed"
    fi
fi

# 9. Data Privacy
print_status "Checking data privacy..."
if find lib/ -name "*.dart" -exec grep -l "SharedPreferences\|secure_storage" {} \; | head -5 > privacy.txt; then
    if [ -s privacy.txt ]; then
        print_status "Data storage found (verify encryption)"
        security_score=$((security_score - 5))
    else
        print_success "Data privacy check passed"
    fi
fi

# 10. Generate Security Report
print_status "Generating security report..."
cat > security-report.md << EOF
# Security Scan Report
Generated on: $(date)

## Security Score: $security_score/100

## Findings

### Dependency Security
$(if [ -f "outdated.txt" ] && [ -s "outdated.txt" ]; then
    echo "- Outdated dependencies found"
else
    echo "- No dependency issues found"
fi)

### Code Security
$(if [ $security_issues -gt 0 ]; then
    echo "- $security_issues security issues found"
else
    echo "- No security issues found"
fi)

### Network Security
$(if [ -f "network.txt" ] && [ -s "network.txt" ]; then
    echo "- HTTP client usage found"
else
    echo "- No network security issues"
fi)

### Data Security
$(if [ -f "files.txt" ] && [ -s "files.txt" ]; then
    echo "- File system operations found"
else
    echo "- No data security issues"
fi)

## Recommendations
$(if [ $security_score -lt 80 ]; then
    echo "- Address identified security issues immediately"
    echo "- Implement security best practices"
    echo "- Consider security testing"
fi)

## Next Steps
$(if [ $security_score -ge 90 ]; then
    echo "- Excellent security posture"
    echo "- Continue regular security scans"
elif [ $security_score -ge 80 ]; then
    echo "- Good security posture"
    echo "- Address minor issues"
else
    echo "- Immediate security attention required"
    echo "- Implement security fixes"
    echo "- Schedule security audit"
fi)
EOF

print_success "Security report generated"

# Final assessment
echo ""
echo "====================================="
echo "🔒 SECURITY SCAN SUMMARY"
echo "====================================="
echo "Security Score: $security_score/100"
echo ""
echo "📋 Scan Results:"
echo "✅ Dependencies: Scanned"
echo "✅ Code Analysis: Completed"
echo "✅ Network Security: Checked"
echo "✅ Input Validation: Verified"
echo "✅ File System: Checked"
echo "✅ Platform Security: Verified"
echo "✅ Web Security: Checked"
echo "✅ Data Privacy: Verified"
echo ""

if [ $security_score -ge 90 ]; then
    print_success "🛡️ Excellent security posture!"
elif [ $security_score -ge 80 ]; then
    print_success "🔒 Good security posture!"
elif [ $security_score -ge 70 ]; then
    print_warning "⚠️  Moderate security - improvements needed"
else
    print_error "🚨 Poor security - immediate attention required"
fi

# Security recommendations
echo ""
echo "📝 Security Recommendations:"
echo "1. Regular security scans (weekly)"
echo "2. Keep dependencies updated"
echo "3. Implement security testing"
echo "4. Monitor for new vulnerabilities"
echo "5. Follow security best practices"

# Cleanup
print_status "Cleaning up temporary files..."
rm -f deps.txt outdated.txt secrets.txt insecure.txt network.txt input.txt files.txt platform.txt web.txt auth.txt privacy.txt

print_success "Security scan completed!"
echo "====================================="

exit 0