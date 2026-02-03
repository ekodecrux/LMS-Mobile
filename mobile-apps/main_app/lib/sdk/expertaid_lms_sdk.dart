/// ExpertaidLMS SDK - Cross-Platform Education Management SDK
/// 
/// This SDK provides a unified interface for integrating ExpertaidLMS
/// functionality into any Flutter application.
library expertaid_lms_sdk;

export 'auth_sdk.dart';
export 'student_sdk.dart';
export 'attendance_sdk.dart';
export 'fee_sdk.dart';
export 'messaging_sdk.dart';
export 'analytics_sdk.dart';

/// Main SDK Configuration Class
class ExpertaidLMSSDK {
  static ExpertaidLMSSDK? _instance;
  late String _baseUrl;
  late String _apiKey;
  
  ExpertaidLMSSDK._internal();
  
  /// Get singleton instance of SDK
  static ExpertaidLMSSDK get instance {
    _instance ??= ExpertaidLMSSDK._internal();
    return _instance!;
  }
  
  /// Initialize SDK with configuration
  void initialize({
    required String baseUrl,
    String? apiKey,
  }) {
    _baseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
    _apiKey = apiKey ?? '';
  }
  
  /// Get configured base URL
  String get baseUrl => _baseUrl;
  
  /// Get configured API key
  String get apiKey => _apiKey;
  
  /// Check if SDK is initialized
  bool get isInitialized => _baseUrl.isNotEmpty;
}
