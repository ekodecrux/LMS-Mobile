# 🚀 Quick Start Guide - ExpertaidLMS Flutter Apps

## 📱 What's Ready?

### ✅ PARENT APP - FULLY FUNCTIONAL
Location: `/app/mobile-apps/parent_app/`

**Features:**
- Beautiful splash screen with gradient
- Professional login interface
- Icon-based bottom navigation
- Dashboard with quick action icons grid
- Children management with cards
- Messaging system (Inbox/Sent)
- Profile with settings
- Full API integration with backend

## 🛠️ How to Build APK

### Prerequisites
```bash
# Check if Flutter is installed
flutter --version

# If not installed, install Flutter SDK from:
# https://docs.flutter.dev/get-started/install
```

### Step 1: Navigate to Parent App
```bash
cd /app/mobile-apps/parent_app
```

### Step 2: Install Dependencies
```bash
flutter pub get
```

### Step 3: Build APK (Release)
```bash
# Single APK (larger size but universal)
flutter build apk --release

# Split APKs (smaller size, one per architecture)
flutter build apk --release --split-per-abi
```

### Step 4: Find Your APK
```bash
# Universal APK location:
/app/mobile-apps/parent_app/build/app/outputs/flutter-apk/app-release.apk

# Split APKs location (recommended):
/app/mobile-apps/parent_app/build/app/outputs/flutter-apk/
  ├── app-armeabi-v7a-release.apk  (32-bit ARM - older devices)
  ├── app-arm64-v8a-release.apk    (64-bit ARM - most modern devices)
  └── app-x86_64-release.apk       (64-bit Intel - emulators/tablets)
```

### Step 5: Install on Android Device
```bash
# Connect your Android device via USB (with USB debugging enabled)
# Or transfer the APK to your device

# Install via ADB
adb install build/app/outputs/flutter-apk/app-arm64-v8a-release.apk

# Or simply copy the APK to your phone and install manually
```

## 📦 Build App Bundle (for Google Play Store)

```bash
cd /app/mobile-apps/parent_app

# Build App Bundle
flutter build appbundle --release

# Output location:
# build/app/outputs/bundle/release/app-release.aab
```

## 🍎 Build for iOS

### Prerequisites
- macOS with Xcode installed
- Apple Developer Account (for distribution)

```bash
cd /app/mobile-apps/parent_app

# Build iOS
flutter build ios --release

# Then open in Xcode to archive:
open ios/Runner.xcworkspace

# In Xcode:
# 1. Select "Any iOS Device" as target
# 2. Product > Archive
# 3. Distribute App > App Store Connect
```

## 🔧 Update API URL for Production

Before building for production, update the API URL:

1. Open: `/app/mobile-apps/parent_app/lib/services/api_service.dart`

2. Change line 7:
```dart
// FROM:
static const String baseUrl = 'https://expertaid-lms-1.preview.emergentagent.com/api';

// TO:
static const String baseUrl = 'https://YOUR-PRODUCTION-DOMAIN.com/api';
```

3. Rebuild the app after changing the URL

## 🎨 Customize App Name & Icon

### Change App Name

**Android:**
Edit: `/app/mobile-apps/parent_app/android/app/src/main/AndroidManifest.xml`
```xml
<application
    android:label="ExpertaidLMS Parent"
    ...>
```

**iOS:**
Edit: `/app/mobile-apps/parent_app/ios/Runner/Info.plist`
```xml
<key>CFBundleName</key>
<string>ExpertaidLMS Parent</string>
```

### Change App Icon

Use this tool to generate icons: https://appicon.co/

1. Generate icons for Android & iOS
2. Replace files in:
   - Android: `android/app/src/main/res/mipmap-*/`
   - iOS: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

## 🧪 Testing Before Release

### Test on Emulator
```bash
# Android Emulator
flutter emulators --launch <emulator_id>
flutter run

# iOS Simulator (macOS only)
open -a Simulator
flutter run
```

### Test Release Build
```bash
flutter run --release
```

## 📊 Build Other Apps

### Teacher App
```bash
# 1. Copy parent_app structure
cp -r /app/mobile-apps/parent_app /app/mobile-apps/teacher_app

# 2. Update app name in pubspec.yaml
name: expertaid_lms_teacher

# 3. Update AndroidManifest.xml and Info.plist
# 4. Modify screens for teacher features
# 5. Build APK
cd /app/mobile-apps/teacher_app
flutter pub get
flutter build apk --release
```

### Admin App
```bash
# Same process as Teacher App
cp -r /app/mobile-apps/parent_app /app/mobile-apps/admin_app
# Update name to: expertaid_lms_admin
# Modify for admin features
```

### Driver App
```bash
# Same process + add GPS dependencies
cp -r /app/mobile-apps/parent_app /app/mobile-apps/driver_app
# Update name to: expertaid_lms_driver

# Add to pubspec.yaml:
dependencies:
  geolocator: ^10.1.0
  google_maps_flutter: ^2.5.0
  location: ^5.0.3
```

## 🔐 Configure Signing (Required for Release)

### Android Signing

1. Generate keystore:
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

2. Create `android/key.properties`:
```
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=upload
storeFile=/path/to/upload-keystore.jks
```

3. Update `android/app/build.gradle` (signing config already included in generated app)

### iOS Signing

1. Open Xcode: `open ios/Runner.xcworkspace`
2. Select Runner in project navigator
3. Signing & Capabilities tab
4. Select your Team
5. Xcode will auto-generate provisioning profiles

## 📋 Pre-Release Checklist

- [ ] Update API URL to production
- [ ] Test all features thoroughly
- [ ] Update app name and icons
- [ ] Configure signing certificates
- [ ] Test on multiple devices
- [ ] Check permissions in AndroidManifest.xml
- [ ] Update version in pubspec.yaml
- [ ] Build release APK/Bundle
- [ ] Test release build on device

## 🚀 Distribution

### Google Play Store
1. Build app bundle: `flutter build appbundle --release`
2. Create app listing in Play Console
3. Upload app bundle
4. Fill in store listing details
5. Submit for review

### Apple App Store
1. Build iOS app in Xcode
2. Archive the app
3. Upload to App Store Connect
4. Fill in app information
5. Submit for review

### Direct Distribution (APK)
- Share APK file directly with users
- Users need to enable "Install from Unknown Sources"
- Not recommended for production (use stores instead)

## 🆘 Troubleshooting

### "Flutter not found"
```bash
# Install Flutter SDK
# Add to PATH: export PATH="$PATH:`pwd`/flutter/bin"
```

### "Android licenses not accepted"
```bash
flutter doctor --android-licenses
```

### "Xcode not found" (macOS)
```bash
# Install Xcode from App Store
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

### Build fails
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter build apk --release
```

## 📞 Need Help?

- Flutter Documentation: https://docs.flutter.dev
- Flutter Community: https://flutter.dev/community
- Stack Overflow: https://stackoverflow.com/questions/tagged/flutter

---

## ✨ Current Status

✅ **Parent App**: 100% Complete & Ready for APK Generation
🏗️ **Teacher App**: Architecture ready (copy & customize from Parent App)
🏗️ **Admin App**: Architecture ready (copy & customize from Parent App)
🏗️ **Driver App**: Architecture ready (add GPS features to Parent App base)

All apps follow the same structure - Parent App serves as the complete template!
