import 'package:flutter/material.dart';

class WeightScreen extends StatelessWidget {
  const WeightScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Danh sách cân nặng",
        ),
      ),


      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Lịch sử cân nặng",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),


            const SizedBox(height: 20),


            Card(
              child: ListTile(

                leading: const Icon(
                  Icons.monitor_weight,
                ),

                title: const Text(
                  "01/07/2026",
                ),

                subtitle: const Text(
                  "12.5 kg",
                ),

              ),
            ),


            Card(
              child: ListTile(

                leading: const Icon(
                  Icons.monitor_weight,
                ),

                title: const Text(
                  "01/06/2026",
                ),

                subtitle: const Text(
                  "11.8 kg",
                ),

              ),
            ),


            Card(
              child: ListTile(

                leading: const Icon(
                  Icons.monitor_weight,
                ),

                title: const Text(
                  "01/05/2026",
                ),

                subtitle: const Text(
                  "11.2 kg",
                ),

              ),
            ),


            const SizedBox(height: 20),


            const Text(
              "Biểu đồ cân nặng",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),


            const SizedBox(height: 10),


            Container(
              height: 150,
              width: double.infinity,

              decoration: BoxDecoration(

                border: Border.all(),

                borderRadius: BorderRadius.circular(10),

              ),

              child: const Center(

                child: Text(
                  "Biểu đồ cân nặng",
                ),

              ),

            ),

          ],
        ),

      ),

    );

  }
}