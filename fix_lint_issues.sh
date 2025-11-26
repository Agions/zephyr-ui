#!/bin/bash

# Script to fix common lint issues in ZephyrUI Flutter project

echo "Starting lint fixes..."

# Fix deprecated withOpacity usage by replacing with withValues
echo "Fixing deprecated withOpacity usage..."
find lib/ -name "*.dart" -type f -exec sed -i '' 's/\.withOpacity(/\.withValues(alpha:/g' {} \;

# Fix deprecated color component usage
echo "Fixing deprecated color component usage..."
find lib/ -name "*.dart" -type f -exec sed -i '' 's/\.red/\.r/g' {} \;
find lib/ -name "*.dart" -type f -exec sed -i '' 's/\.green/\.g/g' {} \;
find lib/ -name "*.dart" -type f -exec sed -i '' 's/\.blue/\.b/g' {} \;

# Fix deprecated value usage in colors
echo "Fixing deprecated color value usage..."
find lib/ -name "*.dart" -type f -exec sed -i '' 's/\.value/.toARGB32()/g' {} \;

echo "Lint fixes completed!"
