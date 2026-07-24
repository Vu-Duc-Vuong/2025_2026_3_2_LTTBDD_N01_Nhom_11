import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../services/weight_service.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {


  List<FlSpot> getChartData() {

    List<FlSpot> spots = [];

    for(int i = 0; i < WeightService.weightList.length; i++) {

      double weight = double.parse(
        WeightService.weightList[i]
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





  double getMinWeight(){

    if(WeightService.weightList.isEmpty){
      return 0;
    }


    double min = double.parse(
      WeightService.weightList[0]
          .weight
          .replaceAll(" kg", ""),
    );


    for(var item in WeightService.weightList){

      double value = double.parse(
        item.weight.replaceAll(" kg", ""),
      );


      if(value < min){
        min = value;
      }

    }


    return min - 1;

  }





  double getMaxWeight(){

    if(WeightService.weightList.isEmpty){
      return 10;
    }


    double max = double.parse(
      WeightService.weightList[0]
          .weight
          .replaceAll(" kg", ""),
    );


    for(var item in WeightService.weightList){

      double value = double.parse(
        item.weight.replaceAll(" kg", ""),
      );


      if(value > max){
        max = value;
      }

    }


    return max + 1;

  }






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

              "Biểu đồ cân nặng",

              style: TextStyle(

                fontSize:20,

                fontWeight: FontWeight.bold,

              ),

            ),




            const SizedBox(height:15),





            SizedBox(

              height:220,


              child:

              weightList.isEmpty

                  ?

              const Center(

                child: Text(
                  "Chưa có dữ liệu",
                ),

              )

                  :

              LineChart(

                LineChartData(



                  minX:0,

                  maxX:
                  (weightList.length - 1).toDouble(),




                  minY:getMinWeight(),


                  maxY:getMaxWeight(),





                  gridData:

                  const FlGridData(
                    show:true,
                  ),





                  titlesData:

                  FlTitlesData(



                    leftTitles:

                    AxisTitles(

                      sideTitles:

                      SideTitles(

                        showTitles:true,

                        reservedSize:40,

                        interval:1,

                      ),

                    ),





                    bottomTitles:

                    AxisTitles(

                      sideTitles:

                      SideTitles(

                        showTitles:true,

                        reservedSize:35,

                        interval:1,


                        getTitlesWidget:

                            (value, meta){


                          int index = value.round();



                          if(index >=0 &&
                              index < weightList.length){



                            return SideTitleWidget(

                              axisSide: meta.axisSide,


                              child:

                              Text(

                                weightList[index]
                                    .date
                                    .substring(0,5),


                                style:

                                const TextStyle(

                                  fontSize:10,

                                ),

                              ),

                            );


                          }


                          return const SizedBox();

                        },


                      ),

                    ),





                    rightTitles:

                    const AxisTitles(

                      sideTitles:

                      SideTitles(

                        showTitles:false,

                      ),

                    ),





                    topTitles:

                    const AxisTitles(

                      sideTitles:

                      SideTitles(

                        showTitles:false,

                      ),

                    ),



                  ),





                  borderData:

                  FlBorderData(

                    show:true,

                  ),





                  lineBarsData: [



                    LineChartBarData(


                      spots:getChartData(),


                      isCurved:true,


                      barWidth:3,


                      dotData:

                      const FlDotData(

                        show:true,

                      ),


                    ),


                  ],





                  lineTouchData:

                  LineTouchData(


                    touchTooltipData:

                    LineTouchTooltipData(


                      getTooltipItems:

                          (spots){



                        return spots.map((spot){


                          int index =
                          spot.x.toInt();



                          return LineTooltipItem(


                            "${weightList[index].date}\n"
                                "${spot.y} kg",



                            const TextStyle(

                              fontWeight:
                              FontWeight.bold,

                            ),


                          );


                        }).toList();



                      },


                    ),


                  ),




                ),

              ),


            ),







            const SizedBox(height:25),






            const Text(

              "Lịch sử cân nặng",


              style:

              TextStyle(

                fontSize:20,

                fontWeight:FontWeight.bold,

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


                itemCount:weightList.length,


                itemBuilder:(context,index){


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