import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://expertaid-lms-1.preview.emergentagent.com/api';

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // ========== AUTHENTICATION ==========
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

  // ========== PARENT APIs ==========
  Future<List<dynamic>> getChildren(String parentId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/parent-student/$parentId'),
      headers: headers,
    );
    if (response.statusCode == 200) return json.decode(response.body);
    throw Exception('Failed to load children');
  }

  Future<Map<String, dynamic>> getStudentAnalytics(String studentId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/students/analytics?student_id=$studentId'),
      headers: headers,
    );
    if (response.statusCode == 200) return json.decode(response.body);
    throw Exception('Failed to load analytics');
  }

  Future<List<dynamic>> getFeeAssignments(String studentId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/fee-assignments/student/$studentId'),
      headers: headers,
    );
    if (response.statusCode == 200) return json.decode(response.body);
    throw Exception('Failed to load fee assignments');
  }

  // ========== TEACHER APIs ==========
  Future<List<dynamic>> getTeacherClasses() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/teacher/classes'),
      headers: headers,
    );
    if (response.statusCode == 200) return json.decode(response.body);
    return [];
  }

  Future<List<dynamic>> getClassStudents(String classId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/classes/$classId/students'),
      headers: headers,
    );
    if (response.statusCode == 200) return json.decode(response.body);
    throw Exception('Failed to load students');
  }

  Future<Map<String, dynamic>> markAttendance(Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/attendance/mark'),
      headers: headers,
      body: json.encode(data),
    );
    if (response.statusCode == 200) return json.decode(response.body);
    throw Exception('Failed to mark attendance');
  }

  Future<List<dynamic>> getAssessments() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/assessments'),
      headers: headers,
    );
    if (response.statusCode == 200) return json.decode(response.body);
    throw Exception('Failed to load assessments');
  }

  // ========== ADMIN APIs ==========
  Future<List<dynamic>> getUsers() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/users'),
      headers: headers,
    );
    if (response.statusCode == 200) return json.decode(response.body);
    throw Exception('Failed to load users');
  }

  Future<List<dynamic>> getClasses() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/classes'),
      headers: headers,
    );
    if (response.statusCode == 200) return json.decode(response.body);
    throw Exception('Failed to load classes');
  }

  Future<Map<String, dynamic>> getDashboardStats() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/admin/dashboard-stats'),
      headers: headers,
    );
    if (response.statusCode == 200) return json.decode(response.body);
    return {};
  }

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: headers,
      body: json.encode(data),
    );
    if (response.statusCode == 200) return json.decode(response.body);
    throw Exception('Failed to create user');
  }

  // ========== COMMON APIs ==========
  Future<List<dynamic>> getMessages() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/messages'),
      headers: headers,
    );
    if (response.statusCode == 200) return json.decode(response.body);
    throw Exception('Failed to load messages');
  }

  Future<Map<String, dynamic>> sendMessage(Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/messages'),
      headers: headers,
      body: json.encode(data),
    );
    if (response.statusCode == 200) return json.decode(response.body);
    throw Exception('Failed to send message');
  }

  Future<List<dynamic>> getAttendance(String studentId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/attendance/student/$studentId'),
      headers: headers,
    );
    if (response.statusCode == 200) return json.decode(response.body);
    throw Exception('Failed to load attendance');
  }
}
