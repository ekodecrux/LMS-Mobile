import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'expertaid_lms_sdk.dart';

/// Authentication SDK Module
class AuthSDK {
  final _storage = const FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  
  /// Login with email and password
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required String role,
  }) async {
    final sdk = ExpertaidLMSSDK.instance;
    if (!sdk.isInitialized) {
      throw Exception('SDK not initialized. Call ExpertaidLMSSDK.instance.initialize() first.');
    }
    
    final response = await http.post(
      Uri.parse('${sdk.baseUrl}/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'role': role,
      }),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _storage.write(key: _tokenKey, value: data['token']);
      await _storage.write(key: _userKey, value: jsonEncode(data['user']));
      return data;
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }
  
  /// Logout and clear stored credentials
  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userKey);
  }
  
  /// Get stored authentication token
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }
  
  /// Get stored user data
  Future<Map<String, dynamic>?> getUser() async {
    final userJson = await _storage.read(key: _userKey);
    if (userJson != null) {
      return jsonDecode(userJson);
    }
    return null;
  }
  
  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
