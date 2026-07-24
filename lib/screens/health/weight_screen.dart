import 'package:flutter/material.dart';


class WeightScreen extends StatelessWidget {

  const WeightScreen({super.key});


  // Dữ liệu tạm
  final List<Map<String, String>> weightList = const [

    {
      "date": "01/06/2026",
      "weight": "10.5 kg",
    },

    {
      "date": "15/06/2026",
      "weight": "11.2 kg",
    },

    {
      "date": "01/07/2026",
      "weight": "12.0 kg",
    },

    {
      "date": "27/07/2026",
      "weight": "12.5 kg",
    },

  ];



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



            const SizedBox(height: 15),





            Expanded(

              child: ListView.builder(

                itemCount: weightList.length,



                itemBuilder: (context, index) {


                  return Card(


                    child: ListTile(


                      leading: const Icon(

                        Icons.monitor_weight,

                        size: 35,

                      ),



                      title: Text(

                        weightList[index]["weight"]!,

                        style: const TextStyle(

                          fontSize: 18,

                          fontWeight: FontWeight.bold,

                        ),

                      ),



                      subtitle: Text(

                        "Ngày cân: ${weightList[index]["date"]}",

                      ),



                    ),

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