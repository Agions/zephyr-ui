#!/bin/bash

# Advanced Lint Fix Script for ZephyrUI
# Focus on the most common remaining lint issues

echo "🔧 Starting advanced lint fixes..."

# Fix example files first (they have simpler issues)
echo "📝 Fixing example files..."

# Fix prefer_const_constructors in examples
find example -name "*.dart" -type f -exec sed -i '' 's/SizedBox(/const SizedBox(/g' {} \;
find example -name "*.dart" -type f -exec sed -i '' 's/Container(/const Container(/g' {} \;
find example -name "*.dart" -type f -exec sed -i '' 's/Padding(/const Padding(/g' {} \;

# Fix avoid_print in examples
find example -name "*.dart" -type f -exec sed -i '' 's/print(/debugPrint(/g' {} \;

# Fix undefined_method issues in examples
find example -name "*.dart" -type f -exec sed -i '' 's/\.primaryColor/\.colorScheme\.primary/g' {} \;
find example -name "*.dart" -type f -exec sed -i '' 's/\.accentColor/\.colorScheme\.secondary/g' {} \;
find example -name "*.dart" -type f -exec sed -i '' 's/\.backgroundColor/\.colorScheme\.surface/g' {} \;

# Fix ZephyrSpaceDirection to Axis conversion
find example -name "*.dart" -type f -exec sed -i '' 's/ZephyrSpaceDirection\.horizontal/Axis\.horizontal/g' {} \;
find example -name "*.dart" -type f -exec sed -i '' 's/ZephyrSpaceDirection\.vertical/Axis\.vertical/g' {} \;

echo "📝 Running dart fix on remaining issues..."
dart fix --apply example/

echo "📝 Running dart format on examples..."
dart format example/

echo "🔧 Running targeted fixes on lib files..."

# Fix deprecated member use
find lib -name "*.dart" -type f -exec sed -i '' 's/Color\.fromRGBO(/Color\.fromARGB(/g' {} \;
find lib -name "*.dart" -type f -exec sed -i '' 's/Color\.fromRGBO(/Color\.fromARGB(/g' {} \;

# Fix some common undefined identifiers
find lib -name "*.dart" -type f -exec sed -i '' 's/\.opacity/\.withOpacity/g' {} \;

echo "📝 Running dart fix on lib files..."
dart fix --apply lib/

echo "📝 Final formatting..."
dart format lib/ example/

echo "✅ Advanced lint fixes completed!"