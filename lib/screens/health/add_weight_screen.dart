import 'package:flutter/material.dart';

import '../../models/weight_model.dart';
import '../../models/pet_model.dart';
import '../../services/weight_service.dart';

class AddWeightScreen extends StatefulWidget {
  final Pet pet;

  const AddWeightScreen({super.key, required this.pet});

  @override
  State<AddWeightScreen> createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  void formatDate(String value) {
    String numbers = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (numbers.length > 8) {
      numbers = numbers.substring(0, 8);
    }

    String formatted = numbers;

    if (numbers.length >= 4) {
      formatted =
          "${numbers.substring(0, 2)}/"
          "${numbers.substring(2, 4)}/"
          "${numbers.substring(4)}";
    } else if (numbers.length >= 2) {
      formatted =
          "${numbers.substring(0, 2)}/"
          "${numbers.substring(2)}";
    }

    dateController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  void saveWeight() {
    if (weightController.text.isEmpty || dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vui lòng nhập đầy đủ thông tin"),
        ),
      );
      return;
    }

    final double? newWeight = double.tryParse(weightController.text);

    if (newWeight == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cân nặng không hợp lệ"),
        ),
      );
      return;
    }

    // Lưu lịch sử cân nặng
    WeightService.addWeight(
      WeightModel(
        petId: widget.pet.id,
        date: dateController.text,
        weight: "${weightController.text} kg",
      ),
    );

    // Cập nhật cân nặng hiện tại của thú cưng
    widget.pet.weight = newWeight;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Đã thêm ${weightController.text} kg cho ${widget.pet.name}",
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    weightController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Thêm cân nặng - ${widget.pet.name}")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.pets, size: 40),
                title: Text(
                  widget.pet.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("${widget.pet.species} - ${widget.pet.breed}"),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: dateController,
              keyboardType: TextInputType.number,
              onChanged: formatDate,
              decoration: const InputDecoration(
                labelText: "Ngày cân (DD/MM/YYYY)",
                hintText: "Ví dụ: 02/08/2026",
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Cân nặng (kg)",
                hintText: "Ví dụ: 3.8",
                prefixIcon: Icon(Icons.monitor_weight),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveWeight,
                child: const Text("Lưu"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}