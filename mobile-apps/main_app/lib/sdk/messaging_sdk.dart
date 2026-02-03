import 'dart:convert';
import 'package:http/http.dart' as http;
import 'expertaid_lms_sdk.dart';
import 'auth_sdk.dart';

/// Messaging SDK Module
class MessagingSDK {
  final AuthSDK _authSDK = AuthSDK();
  
  Future<Map<String, String>> _getHeaders() async {
    final token = await _authSDK.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
  
  /// Get messages for a user
  Future<List<dynamic>> getMessages({String? type}) async {
    final sdk = ExpertaidLMSSDK.instance;
    final headers = await _getHeaders();
    
    String url = '${sdk.baseUrl}/api/messages';
    if (type != null) {
      url += '?type=$type';
    }
    
    final response = await http.get(Uri.parse(url), headers: headers);
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch messages: ${response.body}');
    }
  }
  
  /// Send a message
  Future<Map<String, dynamic>> sendMessage({
    required String recipientId,
    required String subject,
    required String content,
  }) async {
    final sdk = ExpertaidLMSSDK.instance;
    final headers = await _getHeaders();
    
    final response = await http.post(
      Uri.parse('${sdk.baseUrl}/api/messages'),
      headers: headers,
      body: jsonEncode({
        'recipientId': recipientId,
        'subject': subject,
        'content': content,
      }),
    );
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send message: ${response.body}');
    }
  }
}
