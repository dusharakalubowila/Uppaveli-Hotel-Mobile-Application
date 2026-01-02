#!/bin/bash

# Riverpod Setup Script
# This script sets up Riverpod code generation

echo "🚀 Setting up Riverpod..."

# Step 1: Get dependencies
echo "📦 Installing dependencies..."
flutter pub get

# Step 2: Generate provider code
echo "🔨 Generating provider code..."
flutter pub run build_runner build --delete-conflicting-outputs

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Check that all .g.dart files were generated in lib/core/providers/"
echo "2. Start migrating pages to use providers"
echo "3. See RIVERPOD_MIGRATION_GUIDE.md for migration patterns"



