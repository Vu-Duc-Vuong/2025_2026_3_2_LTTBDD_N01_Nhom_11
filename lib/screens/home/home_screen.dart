import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/pet_model.dart';
import '../pet_management/pet_management_screen.dart';
import '../vaccine/vaccine_schedule_screen.dart';
import '../gallery/gallery_screen.dart';
import '../../settings_screen.dart';
import '../../language_notifier.dart';
import '../health/select_pet_weight_screen.dart';
import '../../services/weight_service.dart';
import '../../models/weight_model.dart';
import '../../services/vaccination_service.dart';

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

  List<WeightModel> _getLatestPetWeightList() {
    if (WeightService.weightList.isEmpty) return [];

    final latestRecord = WeightService.weightList.reduce((current, next) {
      final currentDate = _parseDate(current.date);
      final nextDate = _parseDate(next.date);
      return nextDate.isAfter(currentDate) ? next : current;
    });

    final petWeights = WeightService.weightList
        .where((item) => item.petId == latestRecord.petId)
        .toList();
    petWeights.sort((a, b) => _parseDate(a.date).compareTo(_parseDate(b.date)));
    return petWeights;
  }

  List<FlSpot> _getLineChartData(List<WeightModel> weightList) {
    final spots = <FlSpot>[];
    for (int i = 0; i < weightList.length; i++) {
      final weight = _parseWeight(weightList[i].weight);
      spots.add(FlSpot(i.toDouble(), weight));
    }
    return spots;
  }

  double _getMinWeight(List<WeightModel> weightList) {
    if (weightList.isEmpty) return 0;
    var min = _parseWeight(weightList.first.weight);
    for (final item in weightList) {
      final value = _parseWeight(item.weight);
      if (value < min) min = value;
    }
    return min - 1;
  }

  double _getMaxWeight(List<WeightModel> weightList) {
    if (weightList.isEmpty) return 10;
    var max = _parseWeight(weightList.first.weight);
    for (final item in weightList) {
      final value = _parseWeight(item.weight);
      if (value > max) max = value;
    }
    return max + 1;
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
                  ..._buildVaccinationReminderCards(isEnglish),
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
                _showVaccinationNotifications(context, isEnglish);
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
                label: 'Lịch tiêm +',
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

  void _showVaccinationNotifications(BuildContext context, bool isEnglish) {
    final reminders = VaccinationService.getUpcomingVaccinations();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEnglish ? 'Vaccination reminders' : 'Thông báo lịch tiêm',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              if (reminders.isEmpty)
                Text(
                  isEnglish
                      ? 'No upcoming vaccination reminders.'
                      : 'Không có lịch tiêm sắp tới.',
                  style: const TextStyle(color: Colors.grey),
                )
              else
                ...reminders.map(
                  (item) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.vaccines, color: Colors.teal),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${item.petName} • ${item.name}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${isEnglish ? 'Date' : 'Ngày'}: ${item.date}',
                              ),
                              Text(
                                item.note.isNotEmpty
                                    ? item.note
                                    : (isEnglish
                                          ? 'Please prepare in advance.'
                                          : 'Vui lòng chuẩn bị trước.'),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildVaccinationReminderCards(bool isEnglish) {
    final reminders = VaccinationService.getUpcomingVaccinations();
    if (reminders.isEmpty) {
      return [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              isEnglish
                  ? 'No upcoming vaccination reminders.'
                  : 'Không có lịch tiêm sắp tới.',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ];
    }

    return reminders.map((item) {
      return Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          leading: const CircleAvatar(child: Icon(Icons.pets)),
          title: Text(item.name),
          subtitle: Text(item.petName),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item.date),
              Text(
                isEnglish ? 'Upcoming' : 'Sắp tới',
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildWeightChartCard(bool isEnglish) {
    final petNameById = {for (final pet in petList) pet.id: pet.name};
    final latestPetWeightList = _getLatestPetWeightList();
    if (latestPetWeightList.isEmpty) {
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

    final latest = latestPetWeightList.last;
    final petName = petNameById[latest.petId] ?? latest.petId;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEnglish
                  ? 'Weight chart: $petName'
                  : 'Biểu đồ cân nặng: $petName',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              width: double.infinity,
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: (latestPetWeightList.length - 1).toDouble(),
                  minY: _getMinWeight(latestPetWeightList),
                  maxY: _getMaxWeight(latestPetWeightList),
                  gridData: const FlGridData(show: true),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _getLineChartData(latestPetWeightList),
                      isCurved: true,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isEnglish
                  ? 'Latest: ${latest.weight} - ${latest.date}'
                  : 'Mới nhất: ${latest.weight} - ${latest.date}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
