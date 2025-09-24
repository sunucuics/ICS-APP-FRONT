#!/bin/bash

# Android Optimized Build Script
echo "🚀 Starting Android optimized build..."

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean
cd android
./gradlew clean
cd ..

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Build optimized APK
echo "🔨 Building optimized APK..."
flutter build apk --release \
  --target-platform android-arm64,android-arm \
  --split-per-abi \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols \
  --tree-shake-icons

# Build App Bundle (recommended for Play Store)
echo "📱 Building App Bundle..."
flutter build appbundle --release \
  --target-platform android-arm64,android-arm \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols \
  --tree-shake-icons

echo "✅ Build completed successfully!"
echo "📁 APK files: build/app/outputs/flutter-apk/"
echo "📁 AAB file: build/app/outputs/bundle/release/"
