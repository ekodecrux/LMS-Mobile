import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../parent/parent_home_screen.dart';
import '../teacher/teacher_home_screen.dart';
import '../admin/admin_home_screen.dart';

class RoleBasedHome extends StatelessWidget {
  const RoleBasedHome({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final userRole = authService.userRole;

    // Route to appropriate home screen based on user role
    switch (userRole) {
      case 'parent':
        return const ParentHomeScreen();
      case 'teacher':
        return const TeacherHomeScreen();
      case 'institute_admin':
        return const AdminHomeScreen();
      default:
        // If no valid role, logout and go to login
        WidgetsBinding.instance.addPostFrameCallback((_) {
          authService.logout();
          Navigator.pushReplacementNamed(context, '/login');
        });
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
    }
  }
}
