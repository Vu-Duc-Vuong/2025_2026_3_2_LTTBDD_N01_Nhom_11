import 'package0:flutter/material.dart';
import 'theme_notifier.dart';
import 'user_profile_screen.dart';
import 'about_team_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = 'Tiếng Việt';

  // Kiểm tra xem có đang chọn Tiếng Anh không
  bool get _isEnglish => _selectedLanguage == 'English';

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_isEnglish ? 'Select Language' : 'Chọn ngôn ngữ'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('Tiếng Việt'),
                value: 'Tiếng Việt',
                groupValue: _selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text('English'),
                value: 'English',
                groupValue: _selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAppInfoDialog() {
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
        Text(_isEnglish 
          ? 'Professional Pet Care & Management Application.' 
          : 'Ứng dụng Quản lý & Chăm sóc Thú cưng chuyên nghiệp.'),
        const SizedBox(height: 5),
        Text(_isEnglish 
          ? 'Developed by Team 11.' 
          : 'Sản phẩm được hoàn thiện bởi Nhóm 11.'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEnglish ? 'Settings' : 'Cài đặt'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(_isEnglish ? 'Profile' : 'Hồ sơ'),
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
            title: Text(_isEnglish ? 'Language' : 'Đổi ngôn ngữ'),
            subtitle: Text(_selectedLanguage, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: _showLanguageDialog,
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
            title: Text(_isEnglish ? 'About Team' : 'Giới thiệu nhóm'),
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
            title: Text(_isEnglish ? 'App Info' : 'Thông tin ứng dụng'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: _showAppInfoDialog,
          ),
        ],
      ),
    );
  }
}
