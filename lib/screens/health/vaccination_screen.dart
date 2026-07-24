import 'package:flutter/material.dart';


class VaccinationScreen extends StatelessWidget {

  const VaccinationScreen({super.key});



  // Dữ liệu lịch tiêm tạm

  final List<Map<String, String>> vaccinationList = const [

    {
      "name": "Vaccine phòng dại",
      "date": "10/03/2026",
      "status": "Đã tiêm",
    },


    {
      "name": "Vaccine 5 bệnh",
      "date": "15/04/2026",
      "status": "Đã tiêm",
    },


    {
      "name": "Vaccine Care",
      "date": "20/08/2026",
      "status": "Chưa tiêm",
    },

  ];




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



            const SizedBox(height: 15),





            Expanded(

              child: ListView.builder(


                itemCount: vaccinationList.length,



                itemBuilder: (context, index) {



                  bool completed =

                      vaccinationList[index]["status"] == "Đã tiêm";



                  return Card(



                    child: ListTile(



                      leading: Icon(

                        Icons.vaccines,

                        size: 35,

                        color: completed

                            ? Colors.green

                            : Colors.orange,

                      ),




                      title: Text(

                        vaccinationList[index]["name"]!,

                        style: const TextStyle(

                          fontSize: 18,

                          fontWeight: FontWeight.bold,

                        ),

                      ),




                      subtitle: Column(

                        crossAxisAlignment:

                            CrossAxisAlignment.start,

                        children: [



                          Text(

                            "Ngày tiêm: ${vaccinationList[index]["date"]}",

                          ),



                          Text(

                            "Trạng thái: ${vaccinationList[index]["status"]}",

                          ),



                        ],

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