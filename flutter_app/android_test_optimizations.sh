#!/bin/bash

# Android Optimization Test Script
echo "🧪 Testing Android optimizations..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[TEST]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[PASS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[FAIL]${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    print_error "pubspec.yaml not found. Please run this script from the Flutter app root directory."
    exit 1
fi

# Test 1: Check Flutter installation
print_status "Testing Flutter installation..."
if command -v flutter &> /dev/null; then
    print_success "Flutter is installed"
    flutter --version
else
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

# Test 2: Check Android SDK
print_status "Testing Android SDK..."
if command -v adb &> /dev/null; then
    print_success "Android SDK is available"
    adb version
else
    print_warning "Android SDK not found in PATH"
fi

# Test 3: Check dependencies
print_status "Testing dependencies..."
flutter pub get
if [ $? -eq 0 ]; then
    print_success "Dependencies resolved successfully"
else
    print_error "Failed to resolve dependencies"
    exit 1
fi

# Test 4: Check for linting issues
print_status "Testing code quality..."
flutter analyze
if [ $? -eq 0 ]; then
    print_success "No linting issues found"
else
    print_warning "Some linting issues found (check output above)"
fi

# Test 5: Check Android configuration
print_status "Testing Android configuration..."
if [ -f "android/app/build.gradle.kts" ]; then
    print_success "Android build configuration found"
    
    # Check for optimization settings
    if grep -q "isMinifyEnabled = true" android/app/build.gradle.kts; then
        print_success "Minification is enabled"
    else
        print_warning "Minification is not enabled"
    fi
    
    if grep -q "isShrinkResources = true" android/app/build.gradle.kts; then
        print_success "Resource shrinking is enabled"
    else
        print_warning "Resource shrinking is not enabled"
    fi
    
    if grep -q "hardwareAccelerated" android/app/src/main/AndroidManifest.xml; then
        print_success "Hardware acceleration is enabled"
    else
        print_warning "Hardware acceleration is not enabled"
    fi
else
    print_error "Android build configuration not found"
    exit 1
fi

# Test 6: Check ProGuard configuration
print_status "Testing ProGuard configuration..."
if [ -f "android/app/proguard-rules.pro" ]; then
    print_success "ProGuard rules found"
    
    # Check for optimization rules
    if grep -q "optimizations" android/app/proguard-rules.pro; then
        print_success "ProGuard optimizations are configured"
    else
        print_warning "ProGuard optimizations not found"
    fi
else
    print_warning "ProGuard rules not found"
fi

# Test 7: Check network security configuration
print_status "Testing network security configuration..."
if [ -f "android/app/src/main/res/xml/network_security_config.xml" ]; then
    print_success "Network security configuration found"
else
    print_warning "Network security configuration not found"
fi

# Test 8: Check gradle properties
print_status "Testing Gradle properties..."
if [ -f "android/gradle.properties" ]; then
    print_success "Gradle properties found"
    
    # Check for performance settings
    if grep -q "org.gradle.parallel=true" android/gradle.properties; then
        print_success "Parallel builds are enabled"
    else
        print_warning "Parallel builds are not enabled"
    fi
    
    if grep -q "org.gradle.caching=true" android/gradle.properties; then
        print_success "Build caching is enabled"
    else
        print_warning "Build caching is not enabled"
    fi
else
    print_warning "Gradle properties not found"
fi

# Test 9: Check for performance services
print_status "Testing performance services..."
if [ -f "lib/core/services/android_performance_service.dart" ]; then
    print_success "Android performance service found"
else
    print_warning "Android performance service not found"
fi

if [ -f "lib/core/services/memory_management_service.dart" ]; then
    print_success "Memory management service found"
else
    print_warning "Memory management service not found"
fi

if [ -f "lib/core/services/image_cache_service.dart" ]; then
    print_success "Image cache service found"
else
    print_warning "Image cache service not found"
fi

# Test 10: Check for optimized widgets
print_status "Testing optimized widgets..."
if [ -f "lib/core/widgets/optimized_cached_image.dart" ]; then
    print_success "Optimized cached image widget found"
else
    print_warning "Optimized cached image widget not found"
fi

if [ -f "lib/core/widgets/optimized_list_view.dart" ]; then
    print_success "Optimized list view widget found"
else
    print_warning "Optimized list view widget not found"
fi

if [ -f "lib/core/widgets/optimized_animations.dart" ]; then
    print_success "Optimized animations widget found"
else
    print_warning "Optimized animations widget not found"
fi

# Test 11: Check for crash prevention
print_status "Testing crash prevention..."
if [ -f "lib/core/services/crash_prevention_service.dart" ]; then
    print_success "Crash prevention service found"
else
    print_warning "Crash prevention service not found"
fi

# Test 12: Check for build scripts
print_status "Testing build scripts..."
if [ -f "android_optimized_build.sh" ]; then
    print_success "Optimized build script found"
    if [ -x "android_optimized_build.sh" ]; then
        print_success "Build script is executable"
    else
        print_warning "Build script is not executable"
    fi
else
    print_warning "Optimized build script not found"
fi

# Summary
echo ""
echo "📊 Test Summary:"
echo "=================="

# Count successes and warnings
success_count=$(grep -c "\[PASS\]" <<< "$(tail -n +1)")
warning_count=$(grep -c "\[WARN\]" <<< "$(tail -n +1)")
error_count=$(grep -c "\[FAIL\]" <<< "$(tail -n +1)")

echo "✅ Passed: $success_count"
echo "⚠️  Warnings: $warning_count"
echo "❌ Failed: $error_count"

if [ $error_count -eq 0 ]; then
    print_success "🎉 All critical tests passed! Android optimizations are ready."
else
    print_error "❌ Some tests failed. Please check the issues above."
fi

echo ""
echo "💡 Next steps:"
echo "1. Run: ./android_optimized_build.sh"
echo "2. Test the APK on different Android devices"
echo "3. Monitor performance and memory usage"
echo "4. Adjust optimizations based on real-world testing"
