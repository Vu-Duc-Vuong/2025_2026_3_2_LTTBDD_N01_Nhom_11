import 'package:flutter/material.dart';
import 'pet_profile_screen.dart';
import 'weight_screen.dart';
import 'add_weight_screen.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sức khỏe thú cưng",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.pets,
                  size: 40,
                ),

                title: const Text(
                  "Mít",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: const Text(
                  "Golden Retriever - 2 tuổi",
                ),
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
                  child: Card(
                    child: Column(
                      children: const [

                        Icon(
                          Icons.monitor_weight,
                          size: 40,
                        ),

                        Text(
                          "Cân nặng",
                        ),

                        Text(
                          "12.5 kg",
                        ),

                      ],
                    ),
                  ),
                ),


                Expanded(
                  child: Card(
                    child: Column(
                      children: const [

                        Icon(
                          Icons.vaccines,
                          size: 40,
                        ),

                        Text(
                          "Lịch tiêm",
                        ),

                        Text(
                          "3 mũi",
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),


            const SizedBox(height: 20),


            const Text(
              "Chức năng",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),


            // Hồ sơ thú cưng
            ListTile(
              leading: const Icon(
                Icons.person,
              ),

              title: const Text(
                "Hồ sơ thú cưng",
              ),

              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),

              onTap: () {

                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) =>
                        const PetProfileScreen(),
                  ),
                );

              },
            ),


            // Danh sách cân nặng
            ListTile(
              leading: const Icon(
                Icons.monitor_weight,
              ),

              title: const Text(
                "Danh sách cân nặng",
              ),

              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),

              onTap: () {

                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) =>
                        const WeightScreen(),
                  ),
                );

              },
            ),


            // Thêm cân nặng
            ListTile(
              leading: const Icon(
                Icons.add,
              ),

              title: const Text(
                "Thêm cân nặng",
              ),

              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),

              onTap: () {

                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) =>
                        const AddWeightScreen(),
                  ),
                );

              },
            ),


            // Lịch tiêm
            ListTile(
              leading: const Icon(
                Icons.vaccines,
              ),

              title: const Text(
                "Lịch tiêm",
              ),

              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),

            ),

          ],
        ),
      ),
    );
  }
}