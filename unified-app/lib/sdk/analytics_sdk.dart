import 'dart:convert';
import 'package:http/http.dart' as http;
import 'expertaid_lms_sdk.dart';
import 'auth_sdk.dart';

/// Analytics SDK Module
class AnalyticsSDK {
  final AuthSDK _authSDK = AuthSDK();
  
  Future<Map<String, String>> _getHeaders() async {
    final token = await _authSDK.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
  
  /// Get dashboard analytics
  Future<Map<String, dynamic>> getDashboardAnalytics() async {
    final sdk = ExpertaidLMSSDK.instance;
    final headers = await _getHeaders();
    
    final response = await http.get(
      Uri.parse('${sdk.baseUrl}/api/analytics/dashboard'),
      headers: headers,
    );
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch analytics: ${response.body}');
    }
  }
  
  /// Get performance metrics
  Future<Map<String, dynamic>> getPerformanceMetrics({
    String? studentId,
    String? classId,
    String? startDate,
    String? endDate,
  }) async {
    final sdk = ExpertaidLMSSDK.instance;
    final headers = await _getHeaders();
    
    final queryParams = <String, String>{};
    if (studentId != null) queryParams['studentId'] = studentId;
    if (classId != null) queryParams['classId'] = classId;
    if (startDate != null) queryParams['startDate'] = startDate;
    if (endDate != null) queryParams['endDate'] = endDate;
    
    final uri = Uri.parse('${sdk.baseUrl}/api/analytics/performance')
        .replace(queryParameters: queryParams);
    
    final response = await http.get(uri, headers: headers);
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch performance metrics: ${response.body}');
    }
  }
}
