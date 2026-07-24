import 'package:flutter/material.dart';

class AddWeightScreen extends StatefulWidget {
  const AddWeightScreen({super.key});

  @override
  State<AddWeightScreen> createState() => _AddWeightScreenState();
}


class _AddWeightScreenState extends State<AddWeightScreen> {

  final TextEditingController weightController =
      TextEditingController();

  final TextEditingController dateController =
      TextEditingController();


  void saveWeight() {

    if (weightController.text.isEmpty ||
        dateController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text(
            "Vui lòng nhập đầy đủ thông tin",
          ),
        ),

      );

      return;
    }


    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text(
          "Đã thêm ${weightController.text} kg",
        ),
      ),

    );


    weightController.clear();
    dateController.clear();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Thêm cân nặng",
        ),
      ),


      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(

              controller: dateController,

              decoration: const InputDecoration(

                labelText: "Ngày cân",

                prefixIcon: Icon(
                  Icons.calendar_today,
                ),

                border: OutlineInputBorder(),

              ),

            ),


            const SizedBox(height: 20),


            TextField(

              controller: weightController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(

                labelText: "Cân nặng (kg)",

                prefixIcon: Icon(
                  Icons.monitor_weight,
                ),

                border: OutlineInputBorder(),

              ),

            ),


            const SizedBox(height: 30),


            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: saveWeight,

                child: const Text(
                  "Lưu",
                ),

              ),

            ),

          ],

        ),

      ),

    );

  }
}