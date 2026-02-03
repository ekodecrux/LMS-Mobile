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

  Future<List<dynamic>> getMyRoutes() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/driver/routes'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return [];
  }

  Future<Map<String, dynamic>> updateLocation(double lat, double lng) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/driver/location'),
      headers: headers,
      body: json.encode({'latitude': lat, 'longitude': lng}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to update location');
  }

  Future<Map<String, dynamic>> markAttendance(Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/driver/attendance'),
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to mark attendance');
  }

  Future<Map<String, dynamic>> sendEmergencyAlert(String message) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/driver/emergency'),
      headers: headers,
      body: json.encode({'message': message}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to send alert');
  }
}
