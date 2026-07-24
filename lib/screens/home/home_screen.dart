import 'package:flutter/material.dart';
import '../../models/pet_model.dart';
import '../pet_management/pet_management_screen.dart';
import '../../settings_screen.dart';
import '../../language_notifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Danh sách thú cưng dùng chung toàn ứng dụng
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
  ];

  // Điều hướng sang màn hình Quản lý thú cưng và nhận danh sách mới trả về
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "PetCare",
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              "Yêu thương & chăm sóc thú cưng",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.notifications_none,
              size: 30,
            ),
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
                    "Thú cưng\n${petList.length}",
                    Colors.teal,
                    _openPetManagement,
                  ),
                  menu(
                    context,
                    Icons.vaccines,
                    "Lịch tiêm",
                    Colors.deepPurple,
                    () {},
                  ),
                  menu(
                    context,
                    Icons.monitor_weight,
                    "Cân nặng",
                    Colors.orange,
                    () {},
                  ),
                  menu(
                    context,
                    Icons.photo_library,
                    "Thư viện",
                    Colors.redAccent,
                    () {},
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Lịch sắp tới
              rowTitle("Lịch sắp tới"),
              const SizedBox(height: 10),
              scheduleCard(
                "Milo",
                "Tiêm Vaccine Dại",
                "01/06/2024",
                "2 ngày nữa",
              ),
              scheduleCard(
                "Bông",
                "Tiêm Vaccine 5 bệnh",
                "05/06/2024",
                "6 ngày nữa",
              ),
              const SizedBox(height: 25),

              // Cân nặng gần nhất
              rowTitle("Cân nặng gần nhất"),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: weightCard("Lucky", "3.5 kg", "01/05/2024")),
                  const SizedBox(width: 10),
                  Expanded(child: weightCard("Milo", "4.2 kg", "28/04/2024")),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: _openPetManagement,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.teal),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.pets),
                onPressed: _openPetManagement,
              ),
              const SizedBox(width: 30),
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {},
              ),
              // --- ĐÃ KẾT NỐI MÀN HÌNH CÀI ĐẶT TẠI ĐÂY ---
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
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

  Widget rowTitle(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const Text("Xem tất cả", style: TextStyle(color: Colors.teal)),
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

  Widget weightCard(String pet, String weight, String date) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Icon(Icons.show_chart, color: Colors.teal, size: 60),
            const SizedBox(height: 10),
            Text(pet, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(weight),
            Text(date),
          ],
        ),
      ),
    );
  }
}
@override
Widget build(BuildContext context) {
  return ValueListenableBuilder<String>(
    valueListenable: languageNotifier,
    builder: (context, currentLang, child) {
      final isEnglish = currentLang == 'English';

      return Scaffold(
        // Thay các chuỗi văn bản bằng kiểm tra isEnglish:
        // Subtitle: isEnglish ? 'Pet care & love' : 'Yêu thương & chăm sóc thú cưng'
        // Nút Thú cưng: isEnglish ? 'Pets' : 'Thú cưng'
        // Nút Lịch tiêm: isEnglish ? 'Vaccines' : 'Lịch tiêm'
        // Nút Cân nặng: isEnglish ? 'Weight' : 'Cân nặng'
        // Nút Thư viện: isEnglish ? 'Gallery' : 'Thư viện'
        // Tiêu đề: isEnglish ? 'Upcoming Schedule' : 'Lịch sắp tới'
        // Xem tất cả: isEnglish ? 'See all' : 'Xem tất cả'
      );
    },
  );
}
