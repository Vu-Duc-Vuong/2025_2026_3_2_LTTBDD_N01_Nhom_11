import 'package:flutter/material.dart';
import 'theme_notifier.dart';
import 'language_notifier.dart';
import 'user_profile_screen.dart';
import 'about_team_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ValueListenableBuilder<String>(
          valueListenable: languageNotifier,
          builder: (context, currentLang, child) {
            return AlertDialog(
              title: Text(currentLang == 'English' ? 'Select Language' : 'Chọn ngôn ngữ'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: const Text('Tiếng Việt'),
                    value: 'Tiếng Việt',
                    groupValue: currentLang,
                    onChanged: (value) {
                      if (value != null) languageNotifier.value = value;
                      Navigator.pop(context);
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('English'),
                    value: 'English',
                    groupValue: currentLang,
                    onChanged: (value) {
                      if (value != null) languageNotifier.value = value;
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showAppInfoDialog(BuildContext context, bool isEnglish) {
    showAboutDialog(
      context: context,
      applicationName: 'PetCare',
      applicationVersion: 'v1.0.0',
      applicationIcon: const CircleAvatar(
        backgroundColor: Colors.teal,
        child: Icon(Icons.pets, color: Colors.white),
      ),
      children: [
        const SizedBox(height: 10),
        Text(isEnglish 
          ? 'Professional Pet Care & Management Application.' 
          : 'Ứng dụng Quản lý & Chăm sóc Thú cưng chuyên nghiệp.'),
        const SizedBox(height: 5),
        Text(isEnglish 
          ? 'Developed by Team 11.' 
          : 'Sản phẩm được hoàn thiện bởi Nhóm 11.'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, currentLang, child) {
        final isEnglish = currentLang == 'English';

        return Scaffold(
          appBar: AppBar(
            title: Text(isEnglish ? 'Settings' : 'Cài đặt'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(isEnglish ? 'Profile' : 'Hồ sơ'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserProfileScreen()),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(isEnglish ? 'Language' : 'Đổi ngôn ngữ'),
                subtitle: Text(currentLang, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _showLanguageDialog(context),
              ),
              const Divider(),
              ValueListenableBuilder<ThemeMode>(
                valueListenable: themeNotifier,
                builder: (context, currentMode, child) {
                  final isDark = currentMode == ThemeMode.dark;
                  return ListTile(
                    leading: const Icon(Icons.dark_mode),
                    title: const Text('Dark Mode'),
                    trailing: Switch(
                      value: isDark,
                      onChanged: (bool value) {
                        themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
                      },
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.group),
                title: Text(isEnglish ? 'About Team' : 'Giới thiệu nhóm'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutTeamScreen()),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info),
                title: Text(isEnglish ? 'App Info' : 'Thông tin ứng dụng'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _showAppInfoDialog(context, isEnglish),
              ),
            ],
          ),
        );
      },
    );
  }
}
