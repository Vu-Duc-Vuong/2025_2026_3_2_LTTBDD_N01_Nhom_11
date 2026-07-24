import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../services/weight_service.dart';



class WeightScreen extends StatefulWidget {

  const WeightScreen({super.key});


  @override
  State<WeightScreen> createState() =>
      _WeightScreenState();

}





class _WeightScreenState extends State<WeightScreen> {



  List<FlSpot> getChartData(){


    List<FlSpot> spots = [];



    for(int i = 0; i < WeightService.weightList.length; i++){


      double weight =

      double.parse(

        WeightService
            .weightList[i]
            .weight
            .replaceAll(" kg", ""),

      );



      spots.add(

        FlSpot(

          i.toDouble(),

          weight,

        ),

      );


    }



    return spots;


  }






  @override
  Widget build(BuildContext context) {


    final weightList =
        WeightService.weightList;



    return Scaffold(


      appBar:

      AppBar(

        title:
        const Text(
          "Danh sách cân nặng",
        ),

      ),





      body:

      Padding(


        padding:
        const EdgeInsets.all(16),





        child:

        Column(


          crossAxisAlignment:
          CrossAxisAlignment.start,



          children: [





            const Text(


              "Biểu đồ cân nặng",


              style:

              TextStyle(

                fontSize:20,

                fontWeight:
                FontWeight.bold,

              ),


            ),





            const SizedBox(height:15),






            SizedBox(


              height:250,



              child:

              weightList.isEmpty



                  ?

              const Center(

                child:
                Text(
                  "Chưa có dữ liệu",
                ),

              )



                  :

              LineChart(


                LineChartData(


                  gridData:

                  const FlGridData(

                    show:true,

                  ),



                  titlesData:

                  const FlTitlesData(

                    show:true,

                  ),




                  borderData:

                  FlBorderData(

                    show:true,

                  ),





                  lineBarsData: [



                    LineChartBarData(


                      spots:
                      getChartData(),



                      isCurved:true,



                      barWidth:3,



                      dotData:

                      const FlDotData(

                        show:true,

                      ),



                    ),



                  ],



                ),



              ),



            ),





            const SizedBox(height:25),







            const Text(


              "Lịch sử cân nặng",


              style:

              TextStyle(

                fontSize:20,

                fontWeight:
                FontWeight.bold,

              ),


            ),






            const SizedBox(height:15),







            Expanded(


              child:

              weightList.isEmpty



                  ?

              const Center(

                child:
                Text(
                  "Chưa có dữ liệu cân nặng",
                ),

              )



                  :

              ListView.builder(



                itemCount:
                weightList.length,



                itemBuilder:
                    (context,index){



                  return Card(



                    child:

                    ListTile(



                      leading:

                      const Icon(


                        Icons.monitor_weight,


                        size:35,


                      ),





                      title:

                      Text(


                        weightList[index].weight,


                        style:

                        const TextStyle(


                          fontSize:18,


                          fontWeight:
                          FontWeight.bold,


                        ),


                      ),






                      subtitle:

                      Text(


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