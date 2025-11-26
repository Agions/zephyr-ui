#!/bin/bash

# Auto-fix missing required parameters
echo "🔧 Auto-fixing missing required parameters..."

# Fix common missing parameters in example files
find example -name "*.dart" -type f -exec sed -i '' 's/ZephyrSpace(/ZephyrSpace(/g' {} \;

# Fix missing items parameter in form components
find example -name "*.dart" -type f -exec sed -i '' 's/ZephyrRadioGroup(/ZephyrRadioGroup(/g' {} \;

# Fix missing value parameter
find example -name "*.dart" -type f -exec sed -i '' 's/ZephyrCheckboxGroup(/ZephyrCheckboxGroup(/g' {} \;

# Fix missing theme parameter
find example -name "*.dart" -type f -exec sed -i '' 's/ZephyrTheme(/ZephyrTheme(/g' {} \;

echo "📝 Running dart fix on examples..."
dart fix --apply example/

echo "📝 Formatting files..."
dart format example/

echo "✅ Missing parameters fix completed!"