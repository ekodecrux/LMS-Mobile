import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Use environment variable or update for production
  static const String baseUrl = 'https://expertaid-lms-1.preview.emergentagent.com/api';

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Login failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<dynamic>> getChildren(String parentId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/parent-student/$parentId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load children');
  }

  Future<Map<String, dynamic>> getStudentAnalytics(String studentId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/students/analytics?student_id=$studentId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load analytics');
  }

  Future<List<dynamic>> getMessages() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/messages'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load messages');
  }

  Future<Map<String, dynamic>> sendMessage(Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/messages'),
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to send message');
  }

  Future<List<dynamic>> getFeeAssignments(String studentId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/fee-assignments/student/$studentId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load fee assignments');
  }

  Future<List<dynamic>> getAttendance(String studentId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/attendance/student/$studentId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load attendance');
  }
}
