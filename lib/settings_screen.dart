import 'package:flutter/material.dart';
import 'language_notifier.dart';
import 'about_team_screen.dart';
import 'theme_notifier.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _showAppInfoDialog(bool isEnglish) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.teal.shade400,
                radius: 20,
                child: const Icon(Icons.pets, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PetCare',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    'v1.0.0',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ],
          ),
          content: Text(
            isEnglish
                ? 'Professional Pet Care & Management Application.\nProduct completed by Team 11.'
                : 'Ứng dụng Quản lý & Chăm sóc Thú cưng chuyên nghiệp.\nSản phẩm được hoàn thiện bởi Nhóm 11.',
            style: const TextStyle(fontSize: 14, height: 1.4),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                isEnglish ? 'Close' : 'Đóng',
                style: TextStyle(
                  color: Colors.teal.shade300,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, currentLang, child) {
        final isEnglish = currentLang == 'English';

        return Scaffold(
          appBar: AppBar(title: Text(isEnglish ? 'Settings' : 'Cài đặt')),
          body: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(isEnglish ? 'Profile' : 'Hồ sơ'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(isEnglish ? 'Change Language' : 'Đổi ngôn ngữ'),
                subtitle: Text(currentLang),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  if (currentLang == 'Tiếng Việt') {
                    languageNotifier.value = 'English';
                  } else {
                    languageNotifier.value = 'Tiếng Việt';
                  }
                },
              ),
              ValueListenableBuilder<ThemeMode>(
                valueListenable: themeNotifier,
                builder: (context, currentMode, child) {
                  final isDarkEnabled = currentMode == ThemeMode.dark;

                  return SwitchListTile(
                    secondary: const Icon(Icons.dark_mode_outlined),
                    title: const Text('Dark Mode'),
                    value: isDarkEnabled,
                    onChanged: (val) {
                      themeNotifier.value = val
                          ? ThemeMode.dark
                          : ThemeMode.light;
                      setState(() {});
                    },
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.group_outlined),
                title: Text(isEnglish ? 'About Team' : 'Giới thiệu nhóm'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutTeamScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(isEnglish ? 'App Info' : 'Thông tin ứng dụng'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showAppInfoDialog(isEnglish),
              ),
            ],
          ),
        );
      },
    );
  }
}
