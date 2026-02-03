# iOS Build Configuration Guide

This guide explains how to configure and build the ExpertaidLMS Flutter apps for iOS and App Store submission.

## Prerequisites

- macOS computer (required for iOS builds)
- Xcode 14.0 or later
- Apple Developer Account ($99/year)
- Flutter SDK installed
- CocoaPods installed

## Step 1: Install Required Tools

```bash
# Install CocoaPods if not already installed
sudo gem install cocoapods

# Verify installation
pod --version
```

## Step 2: Configure Each App for iOS

For each app (main_app, parent_app, teacher_app, admin_app, driver_app):

### 2.1 Open iOS Project in Xcode

```bash
cd mobile-apps/parent_app
open ios/Runner.xcworkspace
```

### 2.2 Configure Bundle Identifier

1. Select **Runner** in the project navigator
2. Select **Runner** target
3. Go to **General** tab
4. Set **Bundle Identifier**:
   - parent_app: `com.expertaidlms.parent`
   - teacher_app: `com.expertaidlms.teacher`
   - admin_app: `com.expertaidlms.admin`
   - driver_app: `com.expertaidlms.driver`
   - main_app: `com.expertaidlms.expertaid_lms`

### 2.3 Configure Signing

1. Go to **Signing & Capabilities** tab
2. Check **Automatically manage signing**
3. Select your **Team** (Apple Developer Account)
4. Xcode will automatically create provisioning profiles

### 2.4 Update Info.plist

Add required permissions in `ios/Runner/Info.plist`:

```xml
<!-- For all apps -->
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photo library to upload images</string>

<key>NSCameraUsageDescription</key>
<string>We need access to your camera to take photos</string>

<!-- For driver_app only -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to track the bus route</string>

<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>We need your location to provide real-time tracking</string>

<key>UIBackgroundModes</key>
<array>
  <string>location</string>
</array>
```

## Step 3: Build iOS Apps

### 3.1 Build for Testing (Simulator)

```bash
cd mobile-apps/parent_app
flutter build ios --debug
```

### 3.2 Build for Release (Physical Device)

```bash
cd mobile-apps/parent_app
flutter build ios --release
```

### 3.3 Create Archive for App Store

1. Open Xcode workspace
2. Select **Any iOS Device** as destination
3. Go to **Product** → **Archive**
4. Wait for archive to complete
5. Click **Distribute App**
6. Select **App Store Connect**
7. Follow the wizard to upload

## Step 4: App Store Compliance

### 4.1 App Icons

Create app icons for each app:
- Required sizes: 1024x1024 (App Store), 180x180, 120x120, 87x87, 80x80, 60x60, 58x58, 40x40, 29x29, 20x20
- Use PNG format with no transparency
- Place in `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

### 4.2 Launch Screen

Customize launch screen in `ios/Runner/Base.lproj/LaunchScreen.storyboard`

### 4.3 App Store Information

Prepare the following for App Store Connect:

**Required Information:**
- App Name (30 characters max)
- Subtitle (30 characters max)
- Description (4000 characters max)
- Keywords (100 characters max, comma-separated)
- Support URL
- Marketing URL (optional)
- Privacy Policy URL (required)

**Screenshots Required:**
- 6.7" Display (iPhone 14 Pro Max): 1290 x 2796 pixels
- 6.5" Display (iPhone 11 Pro Max): 1242 x 2688 pixels
- 5.5" Display (iPhone 8 Plus): 1242 x 2208 pixels
- iPad Pro (12.9"): 2048 x 2732 pixels

**App Preview Videos (Optional but Recommended):**
- 15-30 seconds
- Same sizes as screenshots
- MP4 or MOV format

### 4.4 Age Rating

Answer the age rating questionnaire in App Store Connect:
- Violence: None
- Medical/Treatment Info: None
- Gambling: None
- Unrestricted Web Access: No
- Made for Kids: No (unless specifically designed for children)

### 4.5 Export Compliance

For apps that use encryption (HTTPS):
- Select "Yes" for encryption
- Select "No" for proprietary encryption
- Provide encryption registration number if required

## Step 5: App Store Submission Checklist

- [ ] All app icons added (all required sizes)
- [ ] Launch screen configured
- [ ] Bundle identifier matches App Store Connect
- [ ] Version number updated
- [ ] Build number incremented
- [ ] Screenshots prepared (all required sizes)
- [ ] App description written
- [ ] Keywords optimized
- [ ] Privacy policy URL provided
- [ ] Support URL provided
- [ ] Age rating completed
- [ ] Export compliance answered
- [ ] Test on physical iOS devices
- [ ] Archive created successfully
- [ ] Uploaded to App Store Connect
- [ ] Submitted for review

## Step 6: Common iOS Issues and Solutions

### Issue: "Runner.app is damaged"
**Solution:** Clean build folder and rebuild
```bash
flutter clean
cd ios
pod deintegrate
pod install
cd ..
flutter build ios
```

### Issue: CocoaPods not found
**Solution:** Install CocoaPods
```bash
sudo gem install cocoapods
pod setup
```

### Issue: Signing certificate issues
**Solution:** 
1. Open Xcode
2. Go to Preferences → Accounts
3. Sign in with Apple ID
4. Download manual profiles
5. Select correct team in project settings

### Issue: Build fails with "No such module"
**Solution:** Clean and reinstall pods
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
flutter clean
flutter pub get
```

## Step 7: TestFlight Distribution

Before App Store submission, test with TestFlight:

1. Upload build to App Store Connect
2. Add internal testers (up to 100)
3. Add external testers (up to 10,000)
4. Collect feedback
5. Fix issues
6. Submit updated build if needed

## Step 8: App Store Review Guidelines

Ensure compliance with Apple's guidelines:

- **2.1 App Completeness**: App must be fully functional
- **2.3 Accurate Metadata**: Screenshots and description must match app
- **4.0 Design**: Follow iOS design guidelines
- **5.1 Privacy**: Implement privacy policy and data handling
- **5.2 Intellectual Property**: Respect copyrights and trademarks

## Support

For iOS-specific issues:
- Apple Developer Forums: https://developer.apple.com/forums/
- Flutter iOS Documentation: https://flutter.dev/docs/deployment/ios

## Notes

- iOS builds can only be created on macOS
- App Store review typically takes 24-48 hours
- Keep your Apple Developer account active
- Update apps regularly to maintain compatibility
