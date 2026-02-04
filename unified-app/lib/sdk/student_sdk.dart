import 'dart:convert';
import 'package:http/http.dart' as http;
import 'expertaid_lms_sdk.dart';
import 'auth_sdk.dart';

/// Student Management SDK Module
class StudentSDK {
  final AuthSDK _authSDK = AuthSDK();
  
  Future<Map<String, String>> _getHeaders() async {
    final token = await _authSDK.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
  
  /// Get student details by ID
  Future<Map<String, dynamic>> getStudent(String studentId) async {
    final sdk = ExpertaidLMSSDK.instance;
    final headers = await _getHeaders();
    
    final response = await http.get(
      Uri.parse('${sdk.baseUrl}/api/students/$studentId'),
      headers: headers,
    );
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch student: ${response.body}');
    }
  }
  
  /// Get students by parent ID
  Future<List<dynamic>> getStudentsByParent(String parentId) async {
    final sdk = ExpertaidLMSSDK.instance;
    final headers = await _getHeaders();
    
    final response = await http.get(
      Uri.parse('${sdk.baseUrl}/api/parent-student/$parentId'),
      headers: headers,
    );
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch students: ${response.body}');
    }
  }
  
  /// Get student analytics
  Future<Map<String, dynamic>> getStudentAnalytics(String studentId) async {
    final sdk = ExpertaidLMSSDK.instance;
    final headers = await _getHeaders();
    
    final response = await http.get(
      Uri.parse('${sdk.baseUrl}/api/students/analytics?studentId=$studentId'),
      headers: headers,
    );
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch analytics: ${response.body}');
    }
  }
}
