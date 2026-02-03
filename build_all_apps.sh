#!/bin/bash

# ExpertaidLMS Mobile Apps Build Script
# This script builds all 5 Flutter apps with Play Store and App Store compliance

set -e  # Exit on error

echo "========================================="
echo "ExpertaidLMS Mobile Apps Builder"
echo "========================================="
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    echo "Visit: https://flutter.dev/docs/get-started/install"
    exit 1
fi

# Check Flutter version
echo "✅ Flutter version:"
flutter --version
echo ""

# Navigate to mobile-apps directory
cd mobile-apps

# Array of apps to build
APPS=("main_app" "parent_app" "teacher_app" "admin_app" "driver_app")

# Build counter
TOTAL_APPS=${#APPS[@]}
CURRENT=0

for app in "${APPS[@]}"; do
  CURRENT=$((CURRENT + 1))
  echo "========================================="
  echo "Building $app ($CURRENT/$TOTAL_APPS)"
  echo "========================================="
  
  cd "$app" || continue
  
  # Clean previous builds
  echo "🧹 Cleaning previous builds..."
  flutter clean
  
  # Get dependencies
  echo "📦 Getting dependencies..."
  flutter pub get
  
  # Build Android APK
  echo "🤖 Building Android APK..."
  flutter build apk --release
  
  # Build Android App Bundle
  echo "📱 Building Android App Bundle..."
  flutter build appbundle --release
  
  # Check if builds were successful
  if [ -f "build/app/outputs/flutter-apk/app-release.apk" ]; then
    echo "✅ APK built successfully"
  else
    echo "❌ APK build failed"
  fi
  
  if [ -f "build/app/outputs/bundle/release/app-release.aab" ]; then
    echo "✅ App Bundle built successfully"
  else
    echo "❌ App Bundle build failed"
  fi
  
  cd ..
  echo "$app build complete!"
  echo ""
done

echo "========================================="
echo "✅ All builds complete!"
echo "========================================="
echo ""
echo "Build outputs:"
for app in "${APPS[@]}"; do
  echo "📁 $app:"
  echo "   APK: mobile-apps/$app/build/app/outputs/flutter-apk/app-release.apk"
  echo "   AAB: mobile-apps/$app/build/app/outputs/bundle/release/app-release.aab"
done
echo ""
echo "Next steps:"
echo "1. Test the APKs on Android devices"
echo "2. Upload AAB files to Google Play Console"
echo "3. Follow the compliance checklist in COMPLIANCE.md"
