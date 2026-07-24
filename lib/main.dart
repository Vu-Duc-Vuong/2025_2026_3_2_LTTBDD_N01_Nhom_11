import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';
import 'theme_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Lắng nghe sự thay đổi của biến themeNotifier để đổi Dark Mode toàn app
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Pet Management",
          
          // Giữ nguyên thiết lập Theme
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          
          // Giữ màn hình HomeScreen từ nhánh remote của nhóm
          home: const HomeScreen(),
        );
      },
    );
  }
}
