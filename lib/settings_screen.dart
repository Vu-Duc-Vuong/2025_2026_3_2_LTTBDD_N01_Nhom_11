import 'package:flutter/material.dart';

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
              // TODO: Code chuyển sang màn hình Hồ sơ sẽ viết ở đây
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
              // TODO: Code xử lý đổi ngôn ngữ
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sắp ra mắt: Đổi ngôn ngữ')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: false, // Tạm thời để false chờ xử lý logic sau
              onChanged: (bool value) {
                // TODO: Code xử lý bật/tắt Dark Mode
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Giới thiệu nhóm'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Code chuyển sang màn hình Giới thiệu nhóm
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
              // TODO: Code chuyển sang Thông tin ứng dụng
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
