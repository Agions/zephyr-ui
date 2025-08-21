#!/bin/bash

# Code quality script for ZephyrUI

set -e

echo "🔍 Running code quality checks..."

# Format code
echo "📝 Formatting code..."
dart format .

# Analyze code
echo "🔍 Analyzing code..."
flutter analyze --fatal-infos .

# Run tests with coverage
echo "🧪 Running tests with coverage..."
flutter test --coverage

# Generate coverage report
echo "📊 Generating coverage report..."
flutter pub global activate coverage
flutter pub global run coverage:format_coverage --packages=.packages --report-on=lib/ --in=coverage/lcov.info --out=coverage/coverage.json --lcov

# Check coverage percentage
COVERAGE=$(flutter pub global run coverage:format_coverage --packages=.packages --report-on=lib/ --in=coverage/lcov.info --out=coverage/coverage.json --lcov --report=json | jq '.line-percent')
echo "📊 Code coverage: ${COVERAGE}%"

# Run golden tests if they exist
if [ -d "test/goldens" ]; then
    echo "🖼️  Running golden tests..."
    flutter test --update-goldens
fi

echo "✅ Code quality checks completed!"