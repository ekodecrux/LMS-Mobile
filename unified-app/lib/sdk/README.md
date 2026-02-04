# ExpertaidLMS SDK

A comprehensive Flutter SDK for integrating ExpertaidLMS functionality into any Flutter application.

## Features

- **Authentication**: Login, logout, token management
- **Student Management**: Student profiles, parent-student relationships
- **Attendance**: Mark and retrieve attendance records
- **Fee Management**: Fee assignments and payment history
- **Messaging**: Send and receive messages
- **Analytics**: Dashboard analytics and performance metrics

## Installation

Add the SDK to your Flutter project by copying the `sdk` folder or importing as a package.

```yaml
dependencies:
  expertaid_lms:
    path: ../main_app
```

## Quick Start

### 1. Initialize SDK

```dart
import 'package:expertaid_lms/sdk/expertaid_lms_sdk.dart';

void main() {
  // Initialize SDK with your API base URL
  ExpertaidLMSSDK.instance.initialize(
    baseUrl: 'https://your-api-url.com',
    apiKey: 'optional-api-key',
  );
  
  runApp(MyApp());
}
```

### 2. Authentication

```dart
import 'package:expertaid_lms/sdk/expertaid_lms_sdk.dart';

final authSDK = AuthSDK();

// Login
try {
  final result = await authSDK.login(
    email: 'user@example.com',
    password: 'password123',
    role: 'parent',
  );
  print('Login successful: ${result['user']}');
} catch (e) {
  print('Login failed: $e');
}

// Check authentication status
bool isAuth = await authSDK.isAuthenticated();

// Logout
await authSDK.logout();
```

### 3. Student Management

```dart
final studentSDK = StudentSDK();

// Get student details
final student = await studentSDK.getStudent('student-id');

// Get students by parent
final students = await studentSDK.getStudentsByParent('parent-id');

// Get student analytics
final analytics = await studentSDK.getStudentAnalytics('student-id');
```

### 4. Attendance Management

```dart
final attendanceSDK = AttendanceSDK();

// Get attendance records
final records = await attendanceSDK.getStudentAttendance(
  'student-id',
  startDate: '2024-01-01',
  endDate: '2024-01-31',
);

// Mark attendance
await attendanceSDK.markAttendance(
  studentId: 'student-id',
  date: '2024-01-15',
  status: 'present',
);
```

### 5. Fee Management

```dart
final feeSDK = FeeSDK();

// Get fee assignments
final fees = await feeSDK.getStudentFees('student-id');

// Get payment history
final payments = await feeSDK.getPaymentHistory('student-id');
```

### 6. Messaging

```dart
final messagingSDK = MessagingSDK();

// Get messages
final messages = await messagingSDK.getMessages(type: 'inbox');

// Send message
await messagingSDK.sendMessage(
  recipientId: 'recipient-id',
  subject: 'Hello',
  content: 'Message content',
);
```

### 7. Analytics

```dart
final analyticsSDK = AnalyticsSDK();

// Get dashboard analytics
final dashboard = await analyticsSDK.getDashboardAnalytics();

// Get performance metrics
final metrics = await analyticsSDK.getPerformanceMetrics(
  studentId: 'student-id',
  startDate: '2024-01-01',
  endDate: '2024-01-31',
);
```

## Error Handling

All SDK methods throw exceptions on failure. Wrap calls in try-catch blocks:

```dart
try {
  final result = await studentSDK.getStudent('student-id');
  // Handle success
} catch (e) {
  // Handle error
  print('Error: $e');
}
```

## Cross-Platform Support

This SDK works on:
- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## API Requirements

The SDK requires a backend API with the following endpoints:

- `POST /api/auth/login` - Authentication
- `GET /api/students/:id` - Student details
- `GET /api/parent-student/:parentId` - Students by parent
- `GET /api/attendance/student/:studentId` - Attendance records
- `POST /api/attendance/mark` - Mark attendance
- `GET /api/fee-assignments/student/:studentId` - Fee assignments
- `GET /api/messages` - Get messages
- `POST /api/messages` - Send message
- `GET /api/analytics/dashboard` - Dashboard analytics

## License

Copyright © 2024 ExpertaidLMS. All rights reserved.
