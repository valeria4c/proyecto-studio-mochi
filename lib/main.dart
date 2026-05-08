import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'screens/auth/login_screen.dart';
import 'screens/admin/admin_dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const StudioMochiApp());
}

class StudioMochiApp extends StatelessWidget {
  const StudioMochiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studio Mochi 22px',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E3B6E),
          primary: const Color(0xFF2E3B6E), // Night Blue
          secondary: const Color(0xFF384057), // Dark Gray Blue
          surface: const Color(0xFFE8E8E6), // Smoke White
          error: Colors.redAccent,
        ),
        scaffoldBackgroundColor: const Color(0xFFE8E8E6),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2E3B6E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/admin': (context) => const AdminDashboardScreen(),
      },
    );
  }
}
