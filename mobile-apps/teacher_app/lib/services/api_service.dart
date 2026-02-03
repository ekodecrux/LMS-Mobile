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

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Login failed');
  }

  Future<List<dynamic>> getTeacherClasses() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/teacher/classes'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load classes');
  }

  Future<List<dynamic>> getClassStudents(String classId) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/classes/$classId/students'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load students');
  }

  Future<Map<String, dynamic>> markAttendance(Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/attendance/mark'),
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to mark attendance');
  }

  Future<List<dynamic>> getAssessments() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/assessments'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load assessments');
  }

  Future<Map<String, dynamic>> createAssessment(Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/assessments'),
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to create assessment');
  }

  Future<List<dynamic>> getLessonPlans() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/lesson-plans'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load lesson plans');
  }
}
