#!/bin/bash

# Fix duplicate const issues
echo "🔧 Fixing duplicate const issues..."

# Fix duplicate const in example files
find example -name "*.dart" -type f -exec sed -i '' 's/const const const/const/g' {} \;
find example -name "*.dart" -type f -exec sed -i '' 's/const const/const/g' {} \;

echo "📝 Running dart format on examples..."
dart format example/

echo "✅ Duplicate const fixes completed!"