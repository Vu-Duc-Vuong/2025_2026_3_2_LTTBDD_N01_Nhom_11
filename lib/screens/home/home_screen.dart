import 'package:flutter/material.dart';
import '../../models/pet_model.dart';
import '../pet_management/pet_management_screen.dart';
import '../vaccine/vaccine_schedule_screen.dart';
import '../gallery/gallery_screen.dart';
import '../../settings_screen.dart';
import '../../language_notifier.dart';
import '../health/select_pet_weight_screen.dart';
import '../../services/weight_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Pet> petList = [
    Pet(
      id: '1',
      name: "Lucky",
      species: "Chó",
      breed: "Poodle",
      gender: "Đực",
      birthDate: "20/04/2022",
      color: "Nâu",
      weight: 3.5,
      ownerName: "Nguyễn Văn A",
      phone: "0901234567",
    ),
    Pet(
      id: '2',
      name: "Milo",
      species: "Mèo",
      breed: "Anh lông ngắn",
      gender: "Đực",
      birthDate: "10/01/2023",
      color: "Xám",
      weight: 4.2,
      ownerName: "Nguyễn Văn A",
      phone: "0901234567",
    ),
    Pet(
      id: '3',
      name: "Bông",
      species: "Mèo",
      breed: "Mèo ta",
      gender: "Cái",
      birthDate: "15/02/2023",
      color: "Trắng vàng",
      weight: 3.8,
      ownerName: "Nguyễn Văn A",
      phone: "0901234567",
    ),
  ];

  void _openPetManagement() async {
    final updatedList = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PetManagementScreen(petList: petList)),
    );

    if (updatedList != null && updatedList is List<Pet>) {
      setState(() {
        petList = updatedList;
      });
    }
  }

  void _openVaccineSchedule() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VaccineScheduleScreen(
          petNames: petList.map((pet) => pet.name).toList(),
        ),
      ),
    );
  }

  void _openWeightScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SelectPetWeightScreen(petList: petList),
      ),
    );
  }

  DateTime _parseDate(String value) {
    final parts = value.split('/');
    if (parts.length != 3) return DateTime(2000);
    final day = int.tryParse(parts[0]) ?? 1;
    final month = int.tryParse(parts[1]) ?? 1;
    final year = int.tryParse(parts[2]) ?? 2000;
    return DateTime(year, month, day);
  }

  double _parseWeight(String value) {
    final cleaned = value.toLowerCase().replaceAll('kg', '').trim();
    return double.tryParse(cleaned) ?? 0;
  }

  List<_WeightChartPoint> _buildWeightChartData() {
    final petNameById = {for (final pet in petList) pet.id: pet.name};
    final points = WeightService.weightList
        .where((item) => petNameById.containsKey(item.petId))
        .map(
          (item) => _WeightChartPoint(
            petName: petNameById[item.petId]!,
            date: item.date,
            dateTime: _parseDate(item.date),
            weight: _parseWeight(item.weight),
          ),
        )
        .toList();
    points.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, currentLang, child) {
        final isEnglish = currentLang == 'English';

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            elevation: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "PetCare",
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  isEnglish
                      ? "Pet care & love"
                      : "Yêu thương & chăm sóc thú cưng",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(Icons.notifications_none, size: 30),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  // Banner
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/pet-banner.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Menu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      menu(
                        context,
                        Icons.pets,
                        isEnglish
                            ? "Pets\n${petList.length}"
                            : "Thú cưng\n${petList.length}",
                        Colors.teal,
                        _openPetManagement,
                      ),
                      menu(
                        context,
                        Icons.vaccines,
                        isEnglish ? "Vaccines" : "Lịch tiêm",
                        Colors.deepPurple,
                        _openVaccineSchedule,
                      ),
                      menu(
                        context,
                        Icons.monitor_weight,
                        isEnglish ? "Weight" : "Cân nặng",
                        Colors.orange,
                        _openWeightScreen,
                      ),
                      menu(
                        context,
                        Icons.photo_library,
                        isEnglish ? "Gallery" : "Thư viện",
                        Colors.redAccent,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GalleryScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Lịch sắp tới
                  rowTitle(
                    isEnglish ? "Upcoming Schedule" : "Lịch sắp tới",
                    isEnglish,
                    onTap: _openVaccineSchedule,
                  ),
                  const SizedBox(height: 10),
                  scheduleCard(
                    "Milo",
                    isEnglish ? "Rabies Vaccine" : "Tiêm Vaccine Dại",
                    "01/06/2024",
                    isEnglish ? "In 2 days" : "2 ngày nữa",
                  ),
                  scheduleCard(
                    "Bông",
                    isEnglish ? "5-in-1 Vaccine" : "Tiêm Vaccine 5 bệnh",
                    "05/06/2024",
                    isEnglish ? "In 6 days" : "6 ngày nữa",
                  ),
                  const SizedBox(height: 25),

                  // Cân nặng gần nhất
                  rowTitle(
                    isEnglish ? "Latest Weight" : "Cân nặng gần nhất",
                    isEnglish,
                    onTap: _openWeightScreen,
                  ),
                  const SizedBox(height: 15),
                  _buildWeightChartCard(isEnglish),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _openPetManagement,
            backgroundColor: Colors.teal,
            icon: const Icon(Icons.add, color: Colors.white),
            label: Text(
              isEnglish ? "Add Pet" : "Thêm thú cưng",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: 0,
            selectedItemColor: Colors.teal,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              if (index == 1) {
                _openPetManagement();
              } else if (index == 2) {
                _openVaccineSchedule();
              } else if (index == 3) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isEnglish
                          ? 'No notifications yet.'
                          : 'Hiện chưa có thông báo.',
                    ),
                  ),
                );
              } else if (index == 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              }
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.pets),
                label: 'Thú cưng',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.vaccines),
                label: 'Lịch tiêm',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none),
                label: 'Thông báo',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Cài đặt',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget menu(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        width: 80,
        height: 90,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 35),
            const SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowTitle(String text, bool isEnglish, {VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              isEnglish ? "See all" : "Xem tất cả",
              style: const TextStyle(color: Colors.teal),
            ),
          ),
        ),
      ],
    );
  }

  Widget scheduleCard(String pet, String vaccine, String date, String remain) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.pets)),
        title: Text(vaccine),
        subtitle: Text(pet),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(date),
            Text(
              remain,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightChartCard(bool isEnglish) {
    final points = _buildWeightChartData();
    if (points.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            isEnglish ? 'No weight records yet.' : 'Chưa có dữ liệu cân nặng.',
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    final latest = points.last;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEnglish
                  ? 'Latest: ${latest.petName} - ${latest.weight.toStringAsFixed(1)} kg (${latest.date})'
                  : 'Mới nhất: ${latest.petName} - ${latest.weight.toStringAsFixed(1)} kg (${latest.date})',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 180,
              width: double.infinity,
              child: CustomPaint(painter: _WeightChartPainter(points: points)),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeightChartPoint {
  final String petName;
  final String date;
  final DateTime dateTime;
  final double weight;

  const _WeightChartPoint({
    required this.petName,
    required this.date,
    required this.dateTime,
    required this.weight,
  });
}

class _WeightChartPainter extends CustomPainter {
  final List<_WeightChartPoint> points;

  _WeightChartPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final minWeight = points
        .map((e) => e.weight)
        .reduce((a, b) => a < b ? a : b);
    final maxWeight = points
        .map((e) => e.weight)
        .reduce((a, b) => a > b ? a : b);
    final range = (maxWeight - minWeight).abs() < 0.001
        ? 1.0
        : (maxWeight - minWeight);

    const leftPadding = 10.0;
    const rightPadding = 10.0;
    const topPadding = 12.0;
    const bottomPadding = 18.0;
    final chartWidth = size.width - leftPadding - rightPadding;
    final chartHeight = size.height - topPadding - bottomPadding;
    final stepX = points.length == 1 ? 0.0 : chartWidth / (points.length - 1);

    final gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;
    for (int i = 0; i < 4; i++) {
      final y = topPadding + chartHeight * (i / 3);
      canvas.drawLine(
        Offset(leftPadding, y),
        Offset(size.width - rightPadding, y),
        gridPaint,
      );
    }

    final linePaint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final dotPaint = Paint()..color = Colors.orange;

    final path = Path();
    for (int i = 0; i < points.length; i++) {
      final x = leftPadding + stepX * i;
      final normalizedY = (points[i].weight - minWeight) / range;
      final y = topPadding + chartHeight * (1 - normalizedY);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      canvas.drawCircle(Offset(x, y), 3.5, dotPaint);
    }
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant _WeightChartPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
