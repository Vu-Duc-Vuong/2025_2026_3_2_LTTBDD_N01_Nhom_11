import 'package:flutter/material.dart';

import '../../models/pet_model.dart';
import '../../language_notifier.dart';
import 'health_screen.dart';

class PetProfileScreen extends StatelessWidget {
  final Pet pet;

  const PetProfileScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, currentLang, child) {
        final isEnglish = currentLang == 'English';

        return Scaffold(
          appBar: AppBar(
            title: Text(isEnglish ? 'Pet profile' : 'Hồ sơ thú cưng'),
          ),

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

                    title: Text(isEnglish ? 'Pet name' : 'Tên thú cưng'),

                    subtitle: Text(pet.name),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.category),

                    title: Text(isEnglish ? 'Species' : 'Giống loài'),

                    subtitle: Text("${pet.species} - ${pet.breed}"),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.cake),

                    title: Text(isEnglish ? 'Date of birth' : 'Ngày sinh'),

                    subtitle: Text(pet.birthDate),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.male),

                    title: Text(isEnglish ? 'Gender' : 'Giới tính'),

                    subtitle: Text(pet.gender),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.palette),

                    title: Text(isEnglish ? 'Coat color' : 'Màu lông'),

                    subtitle: Text(pet.color),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.monitor_weight),

                    title: Text(isEnglish ? 'Weight' : 'Cân nặng'),

                    subtitle: Text("${pet.weight} kg"),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.person),

                    title: Text(isEnglish ? 'Owner' : 'Chủ sở hữu'),

                    subtitle: Text(pet.ownerName),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.phone),

                    title: Text(isEnglish ? 'Phone number' : 'Số điện thoại'),

                    subtitle: Text(pet.phone),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.notes),
                    title: Text(isEnglish ? 'Note' : 'Ghi chú'),
                    subtitle: Text(
                      isEnglish ? 'No notes yet' : 'Chưa có ghi chú',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.health_and_safety),

                    label: Text(
                      isEnglish ? 'Health tracking' : 'Theo dõi sức khỏe',
                    ),

                    onPressed: () {
                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) => HealthScreen(pet: pet),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
