import 'package:flutter/material.dart';

import '../../models/pet_model.dart';
import 'health_screen.dart';

class PetProfileScreen extends StatelessWidget {
  final Pet pet;

  const PetProfileScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hồ sơ thú cưng")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Center(
              child: const CircleAvatar(
                radius: 50,

                child: Icon(Icons.pets, size: 60),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(Icons.pets),

                title: const Text("Tên thú cưng"),

                subtitle: Text(pet.name),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.category),

                title: const Text("Giống loài"),

                subtitle: Text("${pet.species} - ${pet.breed}"),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.cake),

                title: const Text("Ngày sinh"),

                subtitle: Text(pet.birthDate),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.male),

                title: const Text("Giới tính"),

                subtitle: Text(pet.gender),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.palette),

                title: const Text("Màu lông"),

                subtitle: Text(pet.color),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.monitor_weight),

                title: const Text("Cân nặng"),

                subtitle: Text("${pet.weight} kg"),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.person),

                title: const Text("Chủ sở hữu"),

                subtitle: Text(pet.ownerName),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.phone),

                title: const Text("Số điện thoại"),

                subtitle: Text(pet.phone),
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(Icons.notes),

                title: Text("Ghi chú"),

                subtitle: Text("Chưa có ghi chú"),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                icon: const Icon(Icons.health_and_safety),

                label: const Text("Theo dõi sức khỏe"),

                onPressed: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(builder: (_) => HealthScreen(pet: pet)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
