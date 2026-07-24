import 'package:flutter/material.dart';
import '../../services/weight_service.dart';


class WeightScreen extends StatefulWidget {

  const WeightScreen({super.key});


  @override
  State<WeightScreen> createState() => _WeightScreenState();

}



class _WeightScreenState extends State<WeightScreen> {


  @override
  Widget build(BuildContext context) {


    final weightList = WeightService.weightList;


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


              child: weightList.isEmpty


                  ? const Center(

                      child: Text(
                        "Chưa có dữ liệu cân nặng",
                      ),

                    )



                  : ListView.builder(


                      itemCount: weightList.length,



                      itemBuilder: (context, index) {



                        return Card(


                          child: ListTile(


                            leading: const Icon(

                              Icons.monitor_weight,

                              size: 35,

                            ),



                            title: Text(

                              weightList[index].weight,

                              style: const TextStyle(

                                fontSize: 18,

                                fontWeight: FontWeight.bold,

                              ),

                            ),



                            subtitle: Text(

                              "Ngày cân: ${weightList[index].date}",

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