import 'package:flutter/material.dart';
import 'screens/health/health_screen.dart';
import 'theme_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Lắng nghe sự thay đổi của biến themeNotifier
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Pet Management",
          
          // --- KÍCH HOẠT DARK MODE Ở ĐÂY ---
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          // ---------------------------------
          
          home: const HealthScreen(),
        );
      },
    );
  }
}