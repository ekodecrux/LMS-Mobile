# ExpertaidLMS Unified App

A single Flutter application combining all 5 user roles (Student, Parent, Teacher, Admin, Driver) with role-based navigation.

## Quick Build

```bash
flutter pub get
flutter build apk --release
flutter build appbundle --release
```

## Features

- **All Roles in One App**: Student, Parent, Teacher, Admin, Driver
- **Role-Based Navigation**: Automatic routing based on user role
- **Cross-Platform SDK**: Complete SDK for third-party integration
- **GPS Tracking**: Built-in for Driver role

## Build Outputs

- **APK**: `build/app/outputs/flutter-apk/app-release.apk`
- **AAB**: `build/app/outputs/bundle/release/app-release.aab`

## Configuration

Update API endpoint in `lib/services/api_service.dart`:

```dart
static const String baseUrl = 'https://your-api-url.com';
```

## Documentation

- See `../QUICK_BUILD_GUIDE.md` for detailed build instructions
- See `../DEPLOYMENT_SUMMARY.md` for deployment guide
- See `../COMPLIANCE.md` for app store requirements

---

**Package**: com.expertaidlms.expertaid_lms  
**Version**: 1.0.0+1
