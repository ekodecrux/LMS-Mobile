# Quick Build Guide - ExpertaidLMS Mobile Apps

This guide will help you build the APK and App Bundle files for all ExpertaidLMS mobile applications on your local machine.

---

## Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.0.0 or higher) - [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Android Studio** with Android SDK
- **Java JDK 17** or higher
- **Git**

---

## Quick Start

### Step 1: Clone the Repository

```bash
git clone https://github.com/ekodecrux/LMS-Mobile.git
cd LMS-Mobile
```

### Step 2: Choose Your Approach

You have two options:

#### Option A: Build Individual Apps (Recommended for Testing)

Build specific apps based on user roles:

```bash
# Build Parent App
cd mobile-apps/parent_app
flutter pub get
flutter build apk --release
flutter build appbundle --release

# Build Teacher App
cd ../teacher_app
flutter pub get
flutter build apk --release
flutter build appbundle --release

# Build Admin App
cd ../admin_app
flutter pub get
flutter build apk --release
flutter build appbundle --release

# Build Driver App
cd ../driver_app
flutter pub get
flutter build apk --release
flutter build appbundle --release
```

#### Option B: Build Unified App (All Roles in One App)

Build the unified app that contains all user roles:

```bash
cd unified-app
flutter pub get
flutter build apk --release
flutter build appbundle --release
```

### Step 3: Build All Apps at Once (Automated)

Use the provided build script:

```bash
chmod +x build_all_apps.sh
./build_all_apps.sh
```

---

## Build Output Locations

After building, find your files here:

### Individual Apps

**Parent App:**
- APK: `mobile-apps/parent_app/build/app/outputs/flutter-apk/app-release.apk`
- AAB: `mobile-apps/parent_app/build/app/outputs/bundle/release/app-release.aab`

**Teacher App:**
- APK: `mobile-apps/teacher_app/build/app/outputs/flutter-apk/app-release.apk`
- AAB: `mobile-apps/teacher_app/build/app/outputs/bundle/release/app-release.aab`

**Admin App:**
- APK: `mobile-apps/admin_app/build/app/outputs/flutter-apk/app-release.apk`
- AAB: `mobile-apps/admin_app/build/app/outputs/bundle/release/app-release.aab`

**Driver App:**
- APK: `mobile-apps/driver_app/build/app/outputs/flutter-apk/app-release.apk`
- AAB: `mobile-apps/driver_app/build/app/outputs/bundle/release/app-release.aab`

### Unified App

- APK: `unified-app/build/app/outputs/flutter-apk/app-release.apk`
- AAB: `unified-app/build/app/outputs/bundle/release/app-release.aab`

---

## Configuration Before Building

### 1. Update API Endpoint

Update the API base URL in each app:

**File:** `lib/services/api_service.dart`

```dart
static const String baseUrl = 'https://your-api-url.com';
```

### 2. Update Package Names (Optional)

If you want to change package names:

**Android:** Edit `android/app/build.gradle.kts`

```kotlin
applicationId = "com.yourcompany.appname"
```

### 3. Update App Icons (Optional)

Replace default icons:

- **Android:** `android/app/src/main/res/mipmap-*/ic_launcher.png`
- **iOS:** `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

---

## Troubleshooting

### Issue: Flutter command not found

**Solution:**
```bash
export PATH="$PATH:`pwd`/flutter/bin"
flutter doctor
```

### Issue: Android licenses not accepted

**Solution:**
```bash
flutter doctor --android-licenses
```

### Issue: Build fails with Gradle error

**Solution:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk --release
```

### Issue: Dependencies conflict

**Solution:**
```bash
rm pubspec.lock
flutter pub get
```

---

## Testing the APK

### Install on Physical Device

```bash
# Connect your Android device via USB
flutter install
```

Or manually:

```bash
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Test on Emulator

```bash
# Start emulator
flutter emulators --launch <emulator_id>

# Install and run
flutter run --release
```

---

## Building for Different Architectures

### Build APK for Specific Architecture

```bash
# ARM 64-bit (most modern devices)
flutter build apk --release --target-platform android-arm64

# ARM 32-bit (older devices)
flutter build apk --release --target-platform android-arm

# x86 64-bit (emulators)
flutter build apk --release --target-platform android-x64
```

### Build Split APKs (Smaller file sizes)

```bash
flutter build apk --release --split-per-abi
```

This creates separate APKs for each architecture in:
`build/app/outputs/flutter-apk/`

---

## App Store Submission

### For Google Play Store

1. Use the **App Bundle (AAB)** file
2. Upload to Google Play Console
3. Location: `build/app/outputs/bundle/release/app-release.aab`

### For Apple App Store

See `IOS_SETUP_GUIDE.md` for iOS build instructions.

---

## Build Times

Expected build times on a modern machine:

- **First build:** 5-10 minutes per app
- **Subsequent builds:** 2-5 minutes per app
- **All apps (automated script):** 30-45 minutes

---

## Recommended Build Order

For testing and deployment:

1. **Start with Parent App** (most complete, 100% ready)
2. **Then Teacher App** (fully functional)
3. **Then Admin App** (administrative features)
4. **Then Driver App** (GPS features)
5. **Finally Unified App** (all roles combined)

---

## Which Version Should You Use?

### Use Individual Apps If:
- You want separate app store listings
- Different user roles need different branding
- You want to control updates per role
- You need smaller app sizes

### Use Unified App If:
- You want one app for all users
- Users can have multiple roles (e.g., teacher who is also a parent)
- You want simpler maintenance
- You prefer single app store listing

---

## Next Steps After Building

1. **Test the APK** on physical devices
2. **Configure app signing** for Play Store
3. **Prepare store listings** (screenshots, descriptions)
4. **Review compliance** checklist in `COMPLIANCE.md`
5. **Submit to stores** following `DEPLOYMENT_SUMMARY.md`

---

## Support

For issues during building:

1. Run `flutter doctor` to check your environment
2. Check the `DEPLOYMENT_SUMMARY.md` for detailed instructions
3. Review `COMPLIANCE.md` for store requirements
4. Create an issue on GitHub

---

## Summary Commands

```bash
# Quick build for testing (Parent App)
cd mobile-apps/parent_app && flutter pub get && flutter build apk --release

# Quick build for Play Store (Parent App)
cd mobile-apps/parent_app && flutter pub get && flutter build appbundle --release

# Build all apps
./build_all_apps.sh

# Clean and rebuild
flutter clean && flutter pub get && flutter build apk --release
```

---

**Repository:** https://github.com/ekodecrux/LMS-Mobile  
**Build Time:** ~5-10 minutes per app  
**Recommended:** Start with Parent App for fastest results
