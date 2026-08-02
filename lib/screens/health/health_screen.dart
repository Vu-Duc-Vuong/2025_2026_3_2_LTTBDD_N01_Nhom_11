import 'package:flutter/material.dart';

import 'weight_screen.dart';
import 'add_weight_screen.dart';
import 'vaccination_screen.dart';
import '../../settings_screen.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ thú cưng'),
        actions: [
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: const ListTile(
                leading: Icon(Icons.pets, size: 40),
                title: Text(
                  "Mít",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text("Golden Retriever - 2 tuổi"),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Theo dõi sức khỏe",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WeightScreen(),
                        ),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: const [
                            Icon(Icons.monitor_weight, size: 40),
                            SizedBox(height: 8),
                            Text("Cân nặng"),
                            SizedBox(height: 4),
                            Text("12.5 kg"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VaccinationScreen(),
                        ),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: const [
                            Icon(Icons.vaccines, size: 40),
                            SizedBox(height: 8),
                            Text("Lịch tiêm"),
                            SizedBox(height: 4),
                            Text("3 mũi"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              "Chức năng",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Thêm cân nặng"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddWeightScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}