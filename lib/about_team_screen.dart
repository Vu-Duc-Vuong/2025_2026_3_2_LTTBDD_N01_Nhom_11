import 'package:flutter/material.dart';
import 'language_notifier.dart';

class AboutTeamScreen extends StatelessWidget {
  const AboutTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, currentLang, child) {
        final isEnglish = currentLang == 'English';

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black87),
            centerTitle: true,
            title: Text(
              isEnglish ? 'About Team' : 'Giới thiệu nhóm',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.pets, color: Colors.teal.shade400),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Banner PetCare
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5F1), // Xanh ngọc nhạt
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'PetCare',
                        style: TextStyle(
                          color: Colors.teal.shade700,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isEnglish ? 'Pet Management Application' : 'Ứng dụng quản lý thú cưng',
                        style: TextStyle(
                          color: Colors.teal.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Card Thông tin đề tài
                _buildSectionCard(
                  title: isEnglish ? 'Project Information' : 'Thông tin đề tài',
                  icon: Icons.info_outline,
                  child: Column(
                    children: [
                      _buildInfoRow(
                        isEnglish ? 'Project Name:' : 'Tên đề tài:',
                        isEnglish ? 'PetCare Application' : 'Ứng dụng Quản lý Thú Cưng',
                      ),
                      _buildInfoRow(
                        isEnglish ? 'Objective:' : 'Mục tiêu:',
                        isEnglish 
                          ? 'Help users easily manage info, track health, vaccination schedules, and pet photos.' 
                          : 'Giúp người dùng quản lý thông tin, theo dõi sức khỏe, lịch tiêm và hình ảnh của thú cưng một cách dễ dàng.',
                      ),
                      _buildInfoRow(
                        isEnglish ? 'Technology:' : 'Công nghệ:',
                        'Flutter',
                      ),
                      _buildInfoRow(
                        isEnglish ? 'App Type:' : 'Loại ứng dụng:',
                        isEnglish ? 'Frontend (No Backend)' : 'Frontend (Không kết nối Backend)',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Card Thành viên nhóm
                _buildSectionCard(
                  title: isEnglish ? 'Team Members' : 'Thành viên nhóm',
                  icon: Icons.group,
                  child: Column(
                    children: [
                      _buildMemberItem(
                        name: 'Nguyễn Ngọc Lượng',
                        role: isEnglish ? 'Leader' : 'Nhóm trưởng',
                        roleColor: Colors.teal.shade600,
                        mssv: '24106440',
                        tasks: isEnglish 
                          ? 'Home, Pet List, Add/Edit/Delete Pet' 
                          : 'Home, Danh sách thú cưng, Thêm / Sửa / Xóa thú cưng',
                      ),
                      const Divider(height: 20, color: Color(0xFFEEEEEE)),
                      _buildMemberItem(
                        name: 'Vũ Đức Vượng',
                        role: isEnglish ? 'Member' : 'Thành viên',
                        roleColor: Colors.orange.shade600,
                        mssv: '24100383',
                        tasks: isEnglish 
                          ? 'Pet Profile, Weight, Weight Chart' 
                          : 'Hồ sơ thú cưng, Cân nặng, Biểu đồ cân nặng',
                      ),
                      const Divider(height: 20, color: Color(0xFFEEEEEE)),
                      _buildMemberItem(
                        name: 'Nguyễn Văn Nhật Minh',
                        role: isEnglish ? 'Member' : 'Thành viên',
                        roleColor: Colors.orange.shade600,
                        mssv: '24100084',
                        tasks: isEnglish 
                          ? 'Vaccines, Add Vaccine, Gallery, Settings' 
                          : 'Lịch tiêm, Thêm lịch tiêm, Thư viện ảnh, Cài đặt',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionCard({required String title, required IconData icon, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.teal.shade700, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberItem({
    required String name,
    required String role,
    required Color roleColor,
    required String mssv,
    required String tasks,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: roleColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      role,
                      style: TextStyle(
                        color: roleColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text(
                      'MSSV:',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                  ),
                  Text(
                    mssv,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text(
                      'Phụ trách:',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      tasks,
                      style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.3),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        // Icon Mail góc phải như thiết kế
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.mail_outline, color: Colors.teal.shade700, size: 22),
        ),
      ],
    );
  }
}
