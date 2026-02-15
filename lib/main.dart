import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(LeorioClinicApp());
}

class LeorioClinicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leorio Clinic',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        primaryColor: const Color(0xFF2E86DE),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E86DE),
        ),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
