import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/common/splash_screen.dart';
import 'screens/common/login_screen.dart';
import 'screens/common/role_based_home.dart';
import 'services/auth_service.dart';
import 'services/api_service.dart';

void main() {
  runApp(const ExpertaidLMSApp());
}

class ExpertaidLMSApp extends StatelessWidget {
  const ExpertaidLMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        Provider(create: (_) => ApiService()),
      ],
      child: MaterialApp(
        title: 'ExpertaidLMS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF4F46E5), // ExpertLMS Indigo - matches website
            primary: const Color(0xFF4F46E5),
            brightness: Brightness.light,
          ),
          primaryColor: const Color(0xFF4F46E5),
          scaffoldBackgroundColor: Colors.grey[50],
          cardTheme: CardTheme(
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white,
          ),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Color(0xFF4F46E5),
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4F46E5),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.bold),
            headlineMedium: TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(color: Color(0xFF1F2937)),
            bodyMedium: TextStyle(color: Color(0xFF6B7280)),
          ),
        ),
        home: const SplashScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const RoleBasedHome(),
        },
      ),
    );
  }
}
