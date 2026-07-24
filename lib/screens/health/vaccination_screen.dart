import 'package:flutter/material.dart';


class VaccinationScreen extends StatelessWidget {

  const VaccinationScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Lịch tiêm",
        ),

      ),


      body: Padding(

        padding: const EdgeInsets.all(16),


        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,


          children: [


            const Text(

              "Lịch sử tiêm phòng",

              style: TextStyle(

                fontSize: 20,

                fontWeight: FontWeight.bold,

              ),

            ),


            const SizedBox(height: 20),



            Card(

              child: ListTile(

                leading: const Icon(

                  Icons.vaccines,

                  size: 40,

                ),


                title: const Text(

                  "Vaccine dại",

                ),


                subtitle: const Text(

                  "Ngày tiêm: 10/03/2026\nTrạng thái: Đã tiêm",

                ),


              ),

            ),



            Card(

              child: ListTile(

                leading: const Icon(

                  Icons.vaccines,

                  size: 40,

                ),


                title: const Text(

                  "Vaccine 5 bệnh",

                ),


                subtitle: const Text(

                  "Ngày tiêm: 15/06/2026\nTrạng thái: Đã tiêm",

                ),


              ),

            ),



            Card(

              child: ListTile(

                leading: const Icon(

                  Icons.warning,

                  size: 40,

                ),


                title: const Text(

                  "Vaccine cúm",

                ),


                subtitle: const Text(

                  "Ngày tiêm: 20/08/2026\nTrạng thái: Sắp tới",

                ),


              ),

            ),


          ],

        ),

      ),

    );

  }

}