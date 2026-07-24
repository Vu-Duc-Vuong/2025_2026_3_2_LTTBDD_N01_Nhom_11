import 'package:flutter/material.dart';

import '../../models/vaccination_model.dart';
import '../../services/vaccination_service.dart';



class VaccinationScreen extends StatefulWidget {

  const VaccinationScreen({super.key});


  @override
  State<VaccinationScreen> createState() =>
      _VaccinationScreenState();

}



class _VaccinationScreenState extends State<VaccinationScreen> {


  final nameController =
      TextEditingController();


  final dateController =
      TextEditingController();


  final statusController =
      TextEditingController();





  // Tự thêm dấu /
  void formatDate(String value) {


    String numbers = value.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );


    if(numbers.length > 8){

      numbers = numbers.substring(0,8);

    }



    String formatted = numbers;



    if(numbers.length >= 4){


      formatted =
          "${numbers.substring(0,2)}/"
          "${numbers.substring(2,4)}/"
          "${numbers.substring(4)}";



    }
    else if(numbers.length >=2){


      formatted =
          "${numbers.substring(0,2)}/"
          "${numbers.substring(2)}";


    }



    dateController.value =
        TextEditingValue(

          text: formatted,

          selection:
          TextSelection.collapsed(
            offset: formatted.length,
          ),

        );


  }







  void addVaccination(){


    if(nameController.text.isEmpty ||
        dateController.text.isEmpty ||
        statusController.text.isEmpty){


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
            "Vui lòng nhập đầy đủ thông tin",
          ),

        ),

      );


      return;

    }






    if(dateController.text.length != 10){


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
            "Ngày nhập chưa đúng định dạng DD/MM/YYYY",
          ),

        ),

      );


      return;

    }





    List<String> date =
    dateController.text.split("/");



    int day =
    int.parse(date[0]);


    int month =
    int.parse(date[1]);


    int year =
    int.parse(date[2]);






    if(day < 1 || day > 31){


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
            "Ngày phải từ 01 đến 31",
          ),

        ),

      );


      return;


    }







    if(month < 1 || month > 12){


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
            "Tháng phải từ 01 đến 12",
          ),

        ),

      );


      return;


    }







    if(year < 2000 || year > 2100){


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
            "Năm không hợp lệ",
          ),

        ),

      );


      return;


    }







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




    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        content:
        Text(

          "Đã thêm ${nameController.text} ngày ${dateController.text}",

        ),

      ),

    );





    nameController.clear();

    dateController.clear();

    statusController.clear();



    Navigator.pop(context);



  }









  void showAddDialog(){


    showDialog(

      context: context,

      builder:(context){


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

                  border:
                  OutlineInputBorder(),

                ),

              ),



              const SizedBox(height:15),





              TextField(

                controller:
                dateController,

                keyboardType:
                TextInputType.number,


                onChanged:
                formatDate,


                decoration:
                const InputDecoration(

                  labelText:
                  "Ngày tiêm (DD/MM/YYYY)",


                  hintText:
                  "Ví dụ: 27/07/2026",


                  prefixIcon:
                  Icon(Icons.calendar_today),


                  border:
                  OutlineInputBorder(),

                ),

              ),





              const SizedBox(height:15),




              TextField(

                controller:
                statusController,


                decoration:
                const InputDecoration(

                  labelText:
                  "Trạng thái",

                  hintText:
                  "Đã tiêm / Chưa tiêm",

                  border:
                  OutlineInputBorder(),

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

              onPressed:
              addVaccination,


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



      appBar:
      AppBar(

        title:
        const Text(
          "Lịch tiêm",
        ),

      ),




      floatingActionButton:

      FloatingActionButton(

        onPressed:
        showAddDialog,


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

              vaccinationList.isEmpty


                  ?

              const Center(

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
                    (context,index){


                  bool completed =
                      vaccinationList[index].status
                          ==
                          "Đã tiêm";



                  return Card(


                    child:
                    ListTile(


                      leading:
                      Icon(

                        Icons.vaccines,

                        size:35,

                        color:
                        completed
                            ?
                        Colors.green
                            :
                        Colors.orange,

                      ),



                      title:
                      Text(

                        vaccinationList[index].name,

                        style:
                        const TextStyle(

                          fontSize:18,

                          fontWeight:
                          FontWeight.bold,

                        ),

                      ),



                      subtitle:
                      Text(

                        "Ngày tiêm: ${vaccinationList[index].date}\n"
                            "Trạng thái: ${vaccinationList[index].status}",

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