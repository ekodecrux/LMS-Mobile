import 'dart:convert';
import 'package:http/http.dart' as http;
import 'expertaid_lms_sdk.dart';
import 'auth_sdk.dart';

/// Attendance Management SDK Module
class AttendanceSDK {
  final AuthSDK _authSDK = AuthSDK();
  
  Future<Map<String, String>> _getHeaders() async {
    final token = await _authSDK.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
  
  /// Get attendance records for a student
  Future<List<dynamic>> getStudentAttendance(String studentId, {String? startDate, String? endDate}) async {
    final sdk = ExpertaidLMSSDK.instance;
    final headers = await _getHeaders();
    
    String url = '${sdk.baseUrl}/api/attendance/student/$studentId';
    if (startDate != null && endDate != null) {
      url += '?startDate=$startDate&endDate=$endDate';
    }
    
    final response = await http.get(Uri.parse(url), headers: headers);
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch attendance: ${response.body}');
    }
  }
  
  /// Mark attendance
  Future<Map<String, dynamic>> markAttendance({
    required String studentId,
    required String date,
    required String status,
  }) async {
    final sdk = ExpertaidLMSSDK.instance;
    final headers = await _getHeaders();
    
    final response = await http.post(
      Uri.parse('${sdk.baseUrl}/api/attendance/mark'),
      headers: headers,
      body: jsonEncode({
        'studentId': studentId,
        'date': date,
        'status': status,
      }),
    );
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to mark attendance: ${response.body}');
    }
  }
}
