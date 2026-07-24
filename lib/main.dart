import 'package:flutter/material.dart';
import 'screens/health/health_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Management',
      home: const HealthScreen(),
    );
  }
}