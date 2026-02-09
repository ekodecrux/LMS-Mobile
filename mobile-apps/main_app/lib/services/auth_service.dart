import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthService with ChangeNotifier {
  Map<String, dynamic>? _user;
  String? _token;
  bool _isAuthenticated = false;

  Map<String, dynamic>? get user => _user;
  String? get token => _token;
  bool get isAuthenticated => _isAuthenticated;
  String? get userRole => _user?['role'];

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    final token = prefs.getString('auth_token');

    if (userJson != null && token != null) {
      _user = json.decode(userJson);
      _token = token;
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  Future<void> setUser(Map<String, dynamic> userData, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(userData));
    await prefs.setString('auth_token', token);

    _user = userData;
    _token = token;
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.remove('auth_token');

    _user = null;
    _token = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  // Helper to get role-specific color
  Color getRoleColor() {
    switch (userRole) {
      case 'parent':
        return const Color(0xFF6366F1); // Indigo
      case 'teacher':
        return const Color(0xFF10B981); // Green
      case 'institute_admin':
        return const Color(0xFFF59E0B); // Amber
      default:
        return const Color(0xFF6366F1); // Default Indigo
    }
  }

  // Helper to get role display name
  String getRoleDisplayName() {
    switch (userRole) {
      case 'parent':
        return 'Parent';
      case 'teacher':
        return 'Teacher';
      case 'institute_admin':
        return 'Admin';
      default:
        return 'User';
    }
  }
}
