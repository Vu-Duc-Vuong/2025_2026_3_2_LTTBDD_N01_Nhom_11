import 'package:flutter/material.dart';

import '../../services/vaccination_service.dart';
import '../../models/vaccination_model.dart';



class VaccinationScreen extends StatefulWidget {

  const VaccinationScreen({super.key});


  @override
  State<VaccinationScreen> createState() =>
      _VaccinationScreenState();

}



class _VaccinationScreenState extends State<VaccinationScreen> {


  final nameController = TextEditingController();

  final dateController = TextEditingController();

  final statusController = TextEditingController();



  void addVaccination(){


    showDialog(

      context: context,

      builder: (context){


        return AlertDialog(


          title:
          const Text(
            "Thêm lịch tiêm",
          ),



          content:

          Column(

            mainAxisSize:
            MainAxisSize.min,


            children: [


              TextField(

                controller:
                nameController,

                decoration:
                const InputDecoration(

                  labelText:
                  "Tên vaccine",

                ),

              ),



              TextField(

                controller:
                dateController,

                decoration:
                const InputDecoration(

                  labelText:
                  "Ngày tiêm",

                ),

              ),



              TextField(

                controller:
                statusController,

                decoration:
                const InputDecoration(

                  labelText:
                  "Trạng thái",

                ),

              ),


            ],

          ),



          actions: [


            TextButton(

              onPressed: (){

                Navigator.pop(context);

              },


              child:
              const Text(
                "Hủy",
              ),

            ),



            ElevatedButton(

              onPressed: (){


                VaccinationService.addVaccination(

                  VaccinationModel(

                    name:
                    nameController.text,


                    date:
                    dateController.text,


                    status:
                    statusController.text,

                  ),

                );



                setState(() {});


                nameController.clear();

                dateController.clear();

                statusController.clear();



                Navigator.pop(context);


              },


              child:
              const Text(
                "Lưu",
              ),

            ),


          ],


        );


      },


    );


  }




  @override
  Widget build(BuildContext context) {


    final vaccinationList =
        VaccinationService.vaccinationList;



    return Scaffold(


      appBar: AppBar(

        title:
        const Text(
          "Lịch tiêm",
        ),

      ),



      floatingActionButton:

      FloatingActionButton(

        onPressed:
        addVaccination,


        child:
        const Icon(
          Icons.add,
        ),

      ),





      body: Padding(


        padding:
        const EdgeInsets.all(16),



        child: Column(


          crossAxisAlignment:
          CrossAxisAlignment.start,



          children: [



            const Text(


              "Lịch sử tiêm phòng",


              style: TextStyle(


                fontSize: 20,


                fontWeight:
                FontWeight.bold,


              ),


            ),




            const SizedBox(height: 15),





            Expanded(



              child:

              vaccinationList.isEmpty



                  ? const Center(


                child:

                Text(

                  "Chưa có lịch tiêm",

                ),

              )



                  :

              ListView.builder(



                itemCount:
                vaccinationList.length,




                itemBuilder:
                    (context, index) {


                  bool completed =

                      vaccinationList[index]
                          .status ==
                          "Đã tiêm";




                  return Card(



                    child:

                    ListTile(



                      leading:

                      Icon(


                        Icons.vaccines,


                        size: 35,



                        color:

                        completed

                            ? Colors.green

                            : Colors.orange,


                      ),





                      title:

                      Text(



                        vaccinationList[index]
                            .name,



                        style:

                        const TextStyle(



                          fontSize: 18,


                          fontWeight:
                          FontWeight.bold,


                        ),



                      ),






                      subtitle:

                      Column(



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