import 'dart:io';
import 'package:flutter/foundation.dart'; // Import để sử dụng kIsWeb
import 'package:flutter/material.dart';
import '../../models/pet_model.dart';
import '../../language_notifier.dart';
import 'add_pet_screen.dart';
import '../health/pet_profile_screen.dart';

class PetManagementScreen extends StatefulWidget {
  final List<Pet> petList;

  const PetManagementScreen({super.key, required this.petList});

  @override
  State<PetManagementScreen> createState() => _PetManagementScreenState();
}

class _PetManagementScreenState extends State<PetManagementScreen> {
  late List<Pet> pets;

  bool get isEnglish => languageNotifier.value == 'English';

  @override
  void initState() {
    super.initState();
    pets = List.from(widget.petList);
  }

  // Widget hiển thị avatar thú cưng tương thích hoàn toàn trên Web & Mobile
  Widget _buildPetAvatar(String imagePath, {double size = 64}) {
    if (imagePath.isEmpty) {
      return CircleAvatar(
        radius: size / 2,
        backgroundColor: Colors.teal.shade100,
        child: Icon(Icons.pets, color: Colors.teal, size: size * 0.5),
      );
    }

    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child:
            (kIsWeb ||
                imagePath.startsWith('http') ||
                imagePath.startsWith('blob:'))
            ? Image.network(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.teal.shade100,
                    child: Icon(
                      Icons.pets,
                      color: Colors.teal,
                      size: size * 0.5,
                    ),
                  );
                },
              )
            : Image.file(
                File(imagePath),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.teal.shade100,
                    child: Icon(
                      Icons.pets,
                      color: Colors.teal,
                      size: size * 0.5,
                    ),
                  );
                },
              ),
      ),
    );
  }

  // Hộp thoại xác nhận xóa
  void _confirmDelete(Pet pet, int index) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.amber,
                  size: 40,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                isEnglish ? 'Delete Pet' : 'Xóa thú cưng',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                isEnglish
                    ? 'Are you sure you want to delete\n"${pet.name}"?'
                    : 'Bạn có chắc chắn muốn xóa\n"${pet.name}" không?',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        isEnglish ? 'Cancel' : 'Hủy',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          pets.removeAt(index);
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        isEnglish ? 'Delete' : 'Xóa',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, pets);
        return false;
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            isEnglish ? 'Pet List' : 'Danh sách thú cưng',
            style: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor:
              theme.appBarTheme.backgroundColor ?? colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
            onPressed: () => Navigator.pop(context, pets),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              // Banner header
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: colorScheme.primaryContainer.withOpacity(0.5),
                ),
                child: Center(
                  child: Icon(Icons.pets, size: 70, color: colorScheme.primary),
                ),
              ),
              const SizedBox(height: 15),

              // Nút Thêm thú cưng
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final newPet = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddEditPetScreen(),
                      ),
                    );
                    if (newPet != null && newPet is Pet) {
                      setState(() {
                        pets.add(newPet);
                      });
                    }
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: Text(
                    isEnglish ? 'Add Pet' : 'Thêm thú cưng',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff00897B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Danh sách Item
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pets.length,
                itemBuilder: (context, index) {
                  final pet = pets[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PetProfileScreen(pet: pet),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      color: theme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            _buildPetAvatar(pet.imagePath, size: 64),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pet.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "${pet.species} - ${pet.breed}",
                                    style: TextStyle(
                                      color: colorScheme.onSurfaceVariant,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    "${pet.weight} kg",
                                    style: TextStyle(
                                      color: colorScheme.onSurfaceVariant,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.edit_outlined,
                                color: colorScheme.primary,
                              ),
                              onPressed: () async {
                                final updatedPet = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AddEditPetScreen(pet: pet),
                                  ),
                                );
                                if (updatedPet != null && updatedPet is Pet) {
                                  setState(() {
                                    pets[index] = updatedPet;
                                  });
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                color: colorScheme.error,
                              ),
                              onPressed: () => _confirmDelete(pet, index),
                            ),
                          ],
                        ),
                      ),
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
}
