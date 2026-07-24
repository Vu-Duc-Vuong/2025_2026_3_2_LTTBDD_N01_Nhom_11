import 'package:flutter/material.dart';
import '../../services/weight_service.dart';


class AddWeightScreen extends StatefulWidget {

  const AddWeightScreen({super.key});


  @override
  State<AddWeightScreen> createState() => _AddWeightScreenState();

}



class _AddWeightScreenState extends State<AddWeightScreen> {


  final TextEditingController weightController =
      TextEditingController();


  final TextEditingController dateController =
      TextEditingController();



  // Tự thêm dấu /
  void formatDate(String value) {


    String numbers = value.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );


    if (numbers.length > 8) {

      numbers = numbers.substring(0, 8);

    }



    String formatted = numbers;



    if (numbers.length >= 4) {


      formatted =
          "${numbers.substring(0, 2)}/"
          "${numbers.substring(2, 4)}/"
          "${numbers.substring(4)}";


    } else if (numbers.length >= 2) {


      formatted =
          "${numbers.substring(0, 2)}/"
          "${numbers.substring(2)}";

    }



    dateController.value = TextEditingValue(

      text: formatted,

      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),

    );


  }




  void saveWeight() {


    if (weightController.text.isEmpty ||
        dateController.text.isEmpty) {


      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Vui lòng nhập đầy đủ thông tin",
          ),

        ),

      );


      return;

    }





    if (dateController.text.length != 10) {


      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Ngày nhập chưa đúng định dạng DD/MM/YYYY",
          ),

        ),

      );


      return;

    }





    List<String> date =
        dateController.text.split("/");



    int day = int.parse(date[0]);

    int month = int.parse(date[1]);

    int year = int.parse(date[2]);





    if (day < 1 || day > 31) {


      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Ngày phải từ 01 đến 31",
          ),

        ),

      );


      return;

    }





    if (month < 1 || month > 12) {


      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Tháng phải từ 01 đến 12",
          ),

        ),

      );


      return;

    }





    if (year < 2000 || year > 2100) {


      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Năm không hợp lệ",
          ),

        ),

      );


      return;

    }





    // Lưu dữ liệu vào service
    WeightService.addWeight(

      dateController.text,

      "${weightController.text} kg",

    );






    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(

        content: Text(

          "Đã thêm ${weightController.text} kg ngày ${dateController.text}",

        ),

      ),

    );





    weightController.clear();

    dateController.clear();


  }







  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(


        title: const Text(
          "Thêm cân nặng",
        ),


      ),





      body: Padding(


        padding: const EdgeInsets.all(16),





        child: Column(


          children: [





            TextField(


              controller: dateController,



              keyboardType: TextInputType.number,



              onChanged: formatDate,



              decoration: const InputDecoration(


                labelText:
                    "Ngày cân (DD/MM/YYYY)",



                hintText:
                    "Ví dụ: 27/07/2026",




                prefixIcon: Icon(
                  Icons.calendar_today,
                ),



                border:
                    OutlineInputBorder(),



              ),


            ),






            const SizedBox(height: 20),






            TextField(



              controller: weightController,



              keyboardType:
                  TextInputType.number,



              decoration: const InputDecoration(



                labelText:
                    "Cân nặng (kg)",




                hintText:
                    "Ví dụ: 12.5",





                prefixIcon: Icon(
                  Icons.monitor_weight,
                ),




                border:
                    OutlineInputBorder(),



              ),



            ),






            const SizedBox(height: 30),






            SizedBox(


              width:
                  double.infinity,



              child: ElevatedButton(



                onPressed:
                    saveWeight,



                child:
                    const Text(
                      "Lưu",
                    ),



              ),



            ),





          ],



        ),



      ),



    );


  }



}