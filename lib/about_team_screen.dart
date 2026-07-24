import 'package:flutter/material.dart';

class AboutTeamScreen extends StatelessWidget {
  const AboutTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giới thiệu nhóm')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Text(
            'Nhóm 11 - Ứng dụng Quản lý Thú cưng',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.star)),
              title: Text('Nguyễn Văn Nhật Minh'),
              subtitle: Text('Trưởng nhóm / Developer'),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text('Thành viên 2'),
              subtitle: Text('Developer / UI-UX'),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text('Thành viên 3'),
              subtitle: Text('Tester / BA'),
            ),
          ),
        ],
      ),
    );
  }
}
