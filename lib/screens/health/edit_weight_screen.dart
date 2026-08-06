import 'package:flutter/material.dart';
import '../../models/weight_model.dart';
import '../../language_notifier.dart';

class EditWeightScreen extends StatefulWidget {
  final WeightModel weight;

  const EditWeightScreen({super.key, required this.weight});

  @override
  State<EditWeightScreen> createState() => _EditWeightScreenState();
}

class _EditWeightScreenState extends State<EditWeightScreen> {
  late TextEditingController weightController;

  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();

    weightController = TextEditingController(
      text: widget.weight.weight.replaceAll(" kg", ""),
    );

    dateController = TextEditingController(text: widget.weight.date);
  }

  void updateWeight() {
    widget.weight.weight = "${weightController.text} kg";

    widget.weight.date = dateController.text;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, currentLang, child) {
        final isEnglish = currentLang == 'English';

        return Scaffold(
          appBar: AppBar(
            title: Text(isEnglish ? 'Edit weight' : 'Chỉnh sửa cân nặng'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: isEnglish ? 'Date' : 'Ngày cân',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: isEnglish ? 'Weight (kg)' : 'Cân nặng (kg)',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: updateWeight,
                    child: Text(isEnglish ? 'Save changes' : 'Lưu thay đổi'),
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
