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

        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor:
                theme.appBarTheme.backgroundColor ?? colorScheme.surface,
            elevation: 0,
            iconTheme: IconThemeData(color: colorScheme.onSurface),
            centerTitle: true,
            title: Text(
              isEnglish ? 'About Team' : 'Giới thiệu nhóm',
              style: TextStyle(
                color: colorScheme.onSurface,
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
                    color: colorScheme.primaryContainer.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'PetCare',
                        style: TextStyle(
                          color: colorScheme.onPrimaryContainer,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isEnglish
                            ? 'Pet Management Application'
                            : 'Ứng dụng quản lý thú cưng',
                        style: TextStyle(
                          color: colorScheme.onPrimaryContainer,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Card Thông tin đề tài
                _buildSectionCard(
                  context: context,
                  title: isEnglish ? 'Project Information' : 'Thông tin đề tài',
                  icon: Icons.info_outline,
                  child: Column(
                    children: [
                      _buildInfoRow(
                        context,
                        isEnglish ? 'Project Name:' : 'Tên đề tài:',
                        isEnglish
                            ? 'PetCare Application'
                            : 'Ứng dụng Quản lý Thú Cưng',
                      ),
                      _buildInfoRow(
                        context,
                        isEnglish ? 'Objective:' : 'Mục tiêu:',
                        isEnglish
                            ? 'Help users easily manage info, track health, vaccination schedules, and pet photos.'
                            : 'Giúp người dùng quản lý thông tin, theo dõi sức khỏe, lịch tiêm và hình ảnh của thú cưng một cách dễ dàng.',
                      ),
                      _buildInfoRow(
                        context,
                        isEnglish ? 'Technology:' : 'Công nghệ:',
                        'Flutter',
                      ),
                      _buildInfoRow(
                        context,
                        isEnglish ? 'App Type:' : 'Loại ứng dụng:',
                        isEnglish
                            ? 'Frontend (No Backend)'
                            : 'Frontend (Không kết nối Backend)',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Card Thành viên nhóm
                _buildSectionCard(
                  context: context,
                  title: isEnglish ? 'Team Members' : 'Thành viên nhóm',
                  icon: Icons.group,
                  child: Column(
                    children: [
                      _buildMemberItem(
                        context: context,
                        name: 'Nguyễn Ngọc Lượng',
                        role: isEnglish ? 'Leader' : 'Nhóm trưởng',
                        roleColor: Colors.teal.shade600,
                        mssv: '24106440',
                        tasks: isEnglish
                            ? 'Home, Pet List, Add/Edit/Delete Pet'
                            : 'Làm trang Home,Danh sách thú cưng, Thêm/Sửa/Xóa thú cưng, Demo',
                        isEnglish: isEnglish,
                      ),
                      const Divider(height: 20, color: Color(0xFFEEEEEE)),
                      _buildMemberItem(
                        context: context,
                        name: 'Vũ Đức Vượng',
                        role: isEnglish ? 'Member' : 'Thành viên',
                        roleColor: Colors.orange.shade600,
                        mssv: '24100383',
                        tasks: isEnglish
                            ? 'Pet Profile, Weight, Weight Chart'
                            : 'Làm Hồ sơ thú cưng, Cân nặng, Biểu đồ cân nặng, slide, lịch tiêm, viết báo cáo, readme, slide, vẽ sơ đồ, kiểm thử chức năng',
                        isEnglish: isEnglish,
                      ),
                      const Divider(height: 20, color: Color(0xFFEEEEEE)),
                      _buildMemberItem(
                        context: context,
                        name: 'Nguyễn Văn Nhật Minh',
                        role: isEnglish ? 'Member' : 'Thành viên',
                        roleColor: Colors.orange.shade600,
                        mssv: '24100084',
                        tasks: isEnglish
                            ? 'Vaccines, Add Vaccine, Gallery, Settings'
                            : 'Thêm lịch tiêm, Thư viện ảnh, cài đặt, giới thiệu nhóm, vẽ sơ đồ',
                        isEnglish: isEnglish,
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

  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
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

  Widget _buildInfoRow(BuildContext context, String title, String content) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
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
    required BuildContext context,
    required String name,
    required String role,
    required Color roleColor,
    required String mssv,
    required String tasks,
    required bool isEnglish,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: roleColor.withValues(alpha: 0.1),
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
                  SizedBox(
                    width: 80,
                    child: Text(
                      'MSSV:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Text(
                    mssv,
                    style: TextStyle(
                      fontSize: 13,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      isEnglish ? 'Responsible for:' : 'Phụ trách:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      tasks,
                      style: TextStyle(
                        fontSize: 13,
                        color: colorScheme.onSurfaceVariant,
                        height: 1.3,
                      ),
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
            color: colorScheme.primaryContainer.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.mail_outline, color: colorScheme.primary, size: 22),
        ),
      ],
    );
  }
}
