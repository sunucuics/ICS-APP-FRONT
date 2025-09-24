#!/bin/bash

# Android Optimized Build Script with Performance Enhancements
echo "🚀 Starting Android optimized build with performance enhancements..."

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

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    print_error "pubspec.yaml not found. Please run this script from the Flutter app root directory."
    exit 1
fi

# Clean previous builds
print_status "🧹 Cleaning previous builds..."
flutter clean
cd android
./gradlew clean
cd ..

# Get dependencies
print_status "📦 Getting dependencies..."
flutter pub get

# Run code generation
print_status "🔧 Running code generation..."
flutter packages pub run build_runner build --delete-conflicting-outputs

# Build optimized APK with all performance enhancements
print_status "🔨 Building optimized APK with performance enhancements..."

# Build with all optimizations
flutter build apk --release \
  --target-platform android-arm64,android-arm \
  --split-per-abi \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols \
  --tree-shake-icons \
  --dart-define=FLUTTER_WEB_USE_SKIA=true \
  --dart-define=FLUTTER_WEB_AUTO_DETECT=true

# Check if APK build was successful
if [ $? -eq 0 ]; then
    print_success "✅ APK build completed successfully!"
else
    print_error "❌ APK build failed!"
    exit 1
fi

# Build App Bundle (recommended for Play Store)
print_status "📱 Building App Bundle..."
flutter build appbundle --release \
  --target-platform android-arm64,android-arm \
  --obfuscate \
  --split-debug-info=build/app/outputs/symbols \
  --tree-shake-icons

# Check if AAB build was successful
if [ $? -eq 0 ]; then
    print_success "✅ App Bundle build completed successfully!"
else
    print_error "❌ App Bundle build failed!"
    exit 1
fi

# Display build results
print_status "📁 Build outputs:"
echo "   APK files: build/app/outputs/flutter-apk/"
echo "   AAB file: build/app/outputs/bundle/release/"

# Show APK sizes
print_status "📊 APK sizes:"
ls -lh build/app/outputs/flutter-apk/*.apk 2>/dev/null | awk '{print "   " $9 ": " $5}'

# Show AAB size
print_status "📊 AAB size:"
ls -lh build/app/outputs/bundle/release/*.aab 2>/dev/null | awk '{print "   " $9 ": " $5}'

print_success "🎉 Android optimized build completed successfully!"
print_warning "💡 Remember to test the APK on different Android devices for optimal performance."
