import 'package:flutter/material.dart';
import '../../language_notifier.dart';
import '../../settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, currentLang, child) {
        final isEnglish = currentLang == 'English';

        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PetCare',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  isEnglish ? 'Pet Care & Love' : 'Yêu thương & chăm sóc thú cưng',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1543466835-00a7907e9de1?w=800',
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 140,
                      color: Colors.teal.shade800,
                      child: const Center(child: Icon(Icons.pets, size: 50, color: Colors.white)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Quick Action Items
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildQuickAction(Icons.pets, isEnglish ? 'Pets' : 'Thú cưng', '2'),
                    _buildQuickAction(Icons.vaccines, isEnglish ? 'Vaccines' : 'Lịch tiêm', null),
                    _buildQuickAction(Icons.scale, isEnglish ? 'Weight' : 'Cân nặng', null),
                    _buildQuickAction(Icons.photo_library, isEnglish ? 'Gallery' : 'Thư viện', null),
                  ],
                ),
                const SizedBox(height: 25),

                // Section: Upcoming Schedule
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEnglish ? 'Upcoming Schedule' : 'Lịch sắp tới',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        isEnglish ? 'See all' : 'Xem tất cả',
                        style: const TextStyle(color: Colors.teal),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                _buildScheduleItem(
                  title: isEnglish ? 'Rabies Vaccination' : 'Tiêm Vaccine Dại',
                  petName: 'Milo',
                  date: '01/06/2024',
                  daysLeft: isEnglish ? 'In 2 days' : '2 ngày nữa',
                ),
                const SizedBox(height: 10),
                _buildScheduleItem(
                  title: isEnglish ? '5-in-1 Vaccine' : 'Tiêm Vaccine 5 bệnh',
                  petName: 'Bông',
                  date: '05/06/2024',
                  daysLeft: isEnglish ? 'In 6 days' : '6 ngày nữa',
                ),

                const SizedBox(height: 25),

                // Section: Latest Weight
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEnglish ? 'Latest Weight' : 'Cân nặng gần nhất',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        isEnglish ? 'See all' : 'Xem tất cả',
                        style: const TextStyle(color: Colors.teal),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickAction(IconData icon, String label, String? badge) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.teal),
            ),
            if (badge != null)
              Positioned(
                right: -4,
                bottom: -4,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.teal,
                  child: Text(
                    badge,
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildScheduleItem({
    required String title,
    required String petName,
    required String date,
    required String daysLeft,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.deepPurple,
            child: Icon(Icons.pets, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(petName, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(date, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              Text(daysLeft, style: const TextStyle(fontSize: 11, color: Colors.redAccent)),
            ],
          ),
        ],
      ),
    );
  }
}
