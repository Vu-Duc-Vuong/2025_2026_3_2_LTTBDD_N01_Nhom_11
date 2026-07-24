import 'package:flutter/material.dart';
import '../../services/vaccination_service.dart';


class VaccinationScreen extends StatefulWidget {

  const VaccinationScreen({super.key});


  @override
  State<VaccinationScreen> createState() =>
      _VaccinationScreenState();

}



class _VaccinationScreenState extends State<VaccinationScreen> {


  @override
  Widget build(BuildContext context) {


    final vaccinationList =
        VaccinationService.vaccinationList;



    return Scaffold(


      appBar: AppBar(

        title: const Text(
          "Lịch tiêm",
        ),

      ),




      body: Padding(


        padding: const EdgeInsets.all(16),




        child: Column(


          crossAxisAlignment:
              CrossAxisAlignment.start,



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



              child: vaccinationList.isEmpty



                  ? const Center(


                      child: Text(

                        "Chưa có lịch tiêm",

                      ),

                    )



                  : ListView.builder(



                      itemCount:
                          vaccinationList.length,




                      itemBuilder:
                          (context, index) {



                        bool completed =

                            vaccinationList[index]
                                    .status ==
                                "Đã tiêm";




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



                              vaccinationList[index]
                                  .name,



                              style: const TextStyle(



                                fontSize: 18,


                                fontWeight:
                                    FontWeight.bold,



                              ),



                            ),





                            subtitle: Column(



                              crossAxisAlignment:
                                  CrossAxisAlignment.start,



                              children: [



                                Text(



                                  "Ngày tiêm: ${vaccinationList[index].date}",



                                ),




                                Text(



                                  "Trạng thái: ${vaccinationList[index].status}",



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