#!/bin/bash

# Build script for ZephyrUI

set -e

echo "🚀 Building ZephyrUI..."

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean
rm -rf build/

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Run tests
echo "🧪 Running tests..."
flutter test

# Build documentation
echo "📚 Building documentation..."
flutter pub global activate dartdoc
dartdoc .

# Build example app
echo "📱 Building example app..."
cd example
flutter clean
flutter pub get
flutter build apk --release
flutter build ios --release --no-codesign
cd ..

echo "✅ Build completed successfully!"