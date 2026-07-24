import 'package:flutter/material.dart';

class PetProfileScreen extends StatelessWidget {
  const PetProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Hồ sơ thú cưng",
        ),
      ),


      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // Ảnh thú cưng
            Center(
              child: CircleAvatar(
                radius: 50,

                child: const Icon(
                  Icons.pets,
                  size: 60,
                ),
              ),
            ),


            const SizedBox(height: 20),


            const Card(
              child: ListTile(

                leading: Icon(
                  Icons.pets,
                ),

                title: Text(
                  "Tên thú cưng",
                ),

                subtitle: Text(
                  "Mít",
                ),

              ),
            ),


            const Card(
              child: ListTile(

                leading: Icon(
                  Icons.category,
                ),

                title: Text(
                  "Giống loài",
                ),

                subtitle: Text(
                  "Golden Retriever",
                ),

              ),
            ),


            const Card(
              child: ListTile(

                leading: Icon(
                  Icons.cake,
                ),

                title: Text(
                  "Tuổi",
                ),

                subtitle: Text(
                  "2 tuổi",
                ),

              ),
            ),


            const Card(
              child: ListTile(

                leading: Icon(
                  Icons.male,
                ),

                title: Text(
                  "Giới tính",
                ),

                subtitle: Text(
                  "Đực",
                ),

              ),
            ),


            const Card(
              child: ListTile(

                leading: Icon(
                  Icons.notes,
                ),

                title: Text(
                  "Ghi chú",
                ),

                subtitle: Text(
                  "Thú cưng khỏe mạnh",

                ),

              ),
            ),


          ],
        ),
      ),

    );
  }
}