import 'package:flutter/material.dart';

import 'weight_screen.dart';
import 'vaccination_screen.dart';
import '../../settings_screen.dart';
import '../../models/pet_model.dart';

class HealthScreen extends StatelessWidget {
  final Pet pet;

  const HealthScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final latestWeight = "${pet.weight} kg";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ thú cưng'),

        actions: [
          IconButton(
            icon: const Icon(Icons.settings),

            onPressed: () {
              Navigator.push(
                context,

                MaterialPageRoute(builder: (_) => const SettingsScreen()),
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
              child: ListTile(
                leading: const Icon(Icons.pets, size: 40),

                title: Text(
                  pet.name,

                  style: const TextStyle(
                    fontSize: 20,

                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text("${pet.species} - ${pet.breed}"),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Theo dõi sức khỏe",

              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                          builder: (_) => WeightScreen(pet: pet),
                        ),
                      );
                    },

                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),

                        child: Column(
                          children: [
                            const Icon(Icons.monitor_weight, size: 40),

                            const SizedBox(height: 8),

                            const Text("Cân nặng"),

                            const SizedBox(height: 4),

                            Text(
                              latestWeight,

                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
          ],
        ),
      ),
    );
  }
}
