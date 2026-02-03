# ExpertaidLMS Mobile Applications

A comprehensive suite of Flutter mobile applications for education management, designed for students, parents, teachers, administrators, and drivers.

## Overview

This repository contains five role-specific mobile applications that work together to provide a complete Learning Management System (LMS) solution:

| App | Description | Target Users |
|-----|-------------|--------------|
| **Main App** | Core student application with learning features | Students |
| **Parent App** | Parent portal for monitoring student progress | Parents/Guardians |
| **Teacher App** | Teaching tools and classroom management | Teachers/Instructors |
| **Admin App** | Administrative dashboard and system management | School Administrators |
| **Driver App** | Bus tracking and route management | School Bus Drivers |

## Features

### Main App (Student)
- Course enrollment and learning materials
- Attendance tracking
- Grade viewing
- Assignment submission
- Messaging with teachers
- Analytics dashboard

### Parent App
- Monitor multiple children's progress
- View attendance and grades
- Fee payment tracking
- Communication with teachers
- Receive notifications

### Teacher App
- Classroom management
- Attendance marking
- Grade entry
- Assignment creation
- Student performance analytics
- Parent communication

### Admin App
- User management
- Course and class administration
- Fee management
- System-wide analytics
- Report generation

### Driver App
- Real-time GPS tracking
- Route management
- Student pickup/drop-off logging
- Parent notifications
- Trip history

## Technology Stack

- **Framework:** Flutter 3.38.9
- **Language:** Dart 3.10.8
- **State Management:** Provider
- **HTTP Client:** http package
- **Secure Storage:** flutter_secure_storage
- **Charts:** fl_chart
- **GPS (Driver App):** geolocator, google_maps_flutter

## Getting Started

### Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / Xcode (for building)
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/ekodecrux/LMS-Mobile.git
cd LMS-Mobile
```

2. Navigate to the app you want to build:
```bash
cd mobile-apps/parent_app
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Building for Production

### Android (APK & App Bundle)

Use the provided build script to build all apps at once:

```bash
chmod +x build_all_apps.sh
./build_all_apps.sh
```

Or build individual apps:

```bash
cd mobile-apps/parent_app
flutter build apk --release
flutter build appbundle --release
```

Output locations:
- **APK:** `build/app/outputs/flutter-apk/app-release.apk`
- **App Bundle:** `build/app/outputs/bundle/release/app-release.aab`

### iOS

See [IOS_SETUP_GUIDE.md](IOS_SETUP_GUIDE.md) for detailed iOS build instructions.

## SDK Integration

The Main App includes a comprehensive SDK for integrating LMS functionality into other Flutter applications. See [mobile-apps/main_app/lib/sdk/README.md](mobile-apps/main_app/lib/sdk/README.md) for documentation.

### Quick SDK Example

```dart
import 'package:expertaid_lms/sdk/expertaid_lms_sdk.dart';

// Initialize
ExpertaidLMSSDK.instance.initialize(
  baseUrl: 'https://your-api-url.com',
);

// Login
final authSDK = AuthSDK();
await authSDK.login(
  email: 'user@example.com',
  password: 'password',
  role: 'parent',
);

// Fetch student data
final studentSDK = StudentSDK();
final students = await studentSDK.getStudentsByParent('parent-id');
```

## App Store Compliance

Before submitting to app stores, review the compliance checklist:

- **Google Play Store:** See [COMPLIANCE.md](COMPLIANCE.md) for Play Store requirements
- **Apple App Store:** See [IOS_SETUP_GUIDE.md](IOS_SETUP_GUIDE.md) for App Store requirements

### Key Compliance Points

**Google Play Store:**
- Target API level 33+
- Provide privacy policy URL
- Complete data safety section
- Use Android App Bundle (AAB)

**Apple App Store:**
- Provide all required screenshots
- Complete App Privacy details
- Add usage descriptions for permissions
- Follow Human Interface Guidelines

## Project Structure

```
LMS-Mobile/
├── mobile-apps/
│   ├── main_app/          # Student application
│   ├── parent_app/        # Parent portal
│   ├── teacher_app/       # Teacher tools
│   ├── admin_app/         # Admin dashboard
│   └── driver_app/        # Driver tracking
├── build_all_apps.sh      # Automated build script
├── COMPLIANCE.md          # App store compliance guide
├── IOS_SETUP_GUIDE.md     # iOS configuration guide
└── README.md              # This file
```

## Configuration

### API Endpoint

Update the API base URL in each app's configuration:

```dart
// lib/services/api_service.dart
static const String baseUrl = 'https://your-api-url.com';
```

### App Icons

Replace default icons in:
- **Android:** `android/app/src/main/res/mipmap-*/ic_launcher.png`
- **iOS:** `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

### Package Names

Update package names in:
- **Android:** `android/app/build.gradle.kts` (applicationId)
- **iOS:** Xcode project settings (Bundle Identifier)

## Testing

Run tests for each app:

```bash
cd mobile-apps/parent_app
flutter test
```

## Troubleshooting

### Common Issues

**Build fails with "SDK not found"**
```bash
flutter doctor
flutter clean
flutter pub get
```

**Android build fails**
```bash
cd android
./gradlew clean
cd ..
flutter build apk
```

**iOS build fails**
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter build ios
```

## Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

Copyright © 2024 ExpertaidLMS. All rights reserved.

## Support

For issues and questions:
- Create an issue on GitHub
- Email: support@expertaidlms.com
- Documentation: See individual app README files

## Roadmap

- [ ] Web application support
- [ ] Desktop applications (Windows, macOS, Linux)
- [ ] Offline mode
- [ ] Push notifications
- [ ] Video conferencing integration
- [ ] Advanced analytics
- [ ] Multi-language support

## Acknowledgments

Built with Flutter, the cross-platform framework by Google.
