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
            seedColor: const Color(0xFF6366F1), // Professional Indigo
            brightness: Brightness.light,
          ),
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
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
