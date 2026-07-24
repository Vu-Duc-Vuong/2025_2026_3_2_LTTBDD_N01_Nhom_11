import 'package:flutter/material.dart';
import 'theme_notifier.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Hồ sơ'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sắp ra mắt: Hồ sơ')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Đổi ngôn ngữ'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sắp ra mắt: Đổi ngôn ngữ')),
              );
            },
          ),
          const Divider(),
          // ĐOẠN NÀY LÀ CỦA DARK MODE
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (context, currentMode, child) {
              return ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: currentMode == ThemeMode.dark,
                  onChanged: (bool value) {
                    // Đổi trạng thái khi bấm công tắc
                    themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
                  },
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Giới thiệu nhóm'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sắp ra mắt: Giới thiệu nhóm')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Thông tin ứng dụng'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sắp ra mắt: Thông tin ứng dụng')),
              );
            },
          ),
        ],
      ),
    );
  }
}
