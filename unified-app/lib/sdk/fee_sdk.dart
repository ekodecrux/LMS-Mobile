import 'dart:convert';
import 'package:http/http.dart' as http;
import 'expertaid_lms_sdk.dart';
import 'auth_sdk.dart';

/// Fee Management SDK Module
class FeeSDK {
  final AuthSDK _authSDK = AuthSDK();
  
  Future<Map<String, String>> _getHeaders() async {
    final token = await _authSDK.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
  
  /// Get fee assignments for a student
  Future<List<dynamic>> getStudentFees(String studentId) async {
    final sdk = ExpertaidLMSSDK.instance;
    final headers = await _getHeaders();
    
    final response = await http.get(
      Uri.parse('${sdk.baseUrl}/api/fee-assignments/student/$studentId'),
      headers: headers,
    );
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch fees: ${response.body}');
    }
  }
  
  /// Get payment history
  Future<List<dynamic>> getPaymentHistory(String studentId) async {
    final sdk = ExpertaidLMSSDK.instance;
    final headers = await _getHeaders();
    
    final response = await http.get(
      Uri.parse('${sdk.baseUrl}/api/payments/student/$studentId'),
      headers: headers,
    );
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch payment history: ${response.body}');
    }
  }
}
