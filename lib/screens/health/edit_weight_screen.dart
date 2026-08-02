import 'package:flutter/material.dart';
import '../../models/weight_model.dart';


class EditWeightScreen extends StatefulWidget {

  final WeightModel weight;


  const EditWeightScreen({
    super.key,
    required this.weight,
  });


  @override
  State<EditWeightScreen> createState() => _EditWeightScreenState();

}



class _EditWeightScreenState extends State<EditWeightScreen>{


  late TextEditingController weightController;

  late TextEditingController dateController;



  @override
  void initState(){

    super.initState();


    weightController = TextEditingController(
      text: widget.weight.weight.replaceAll(" kg", ""),
    );


    dateController = TextEditingController(
      text: widget.weight.date,
    );

  }




  void updateWeight(){


    widget.weight.weight =
        "${weightController.text} kg";


    widget.weight.date =
        dateController.text;



    Navigator.pop(context);


  }




  @override
  Widget build(BuildContext context){


    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Chỉnh sửa cân nặng",
        ),
      ),



      body: Padding(

        padding: const EdgeInsets.all(16),


        child: Column(

          children:[


            TextField(

              controller: dateController,

              decoration: const InputDecoration(

                labelText:"Ngày cân",

                border:OutlineInputBorder(),

              ),

            ),



            const SizedBox(height:20),



            TextField(

              controller: weightController,

              keyboardType:TextInputType.number,

              decoration: const InputDecoration(

                labelText:"Cân nặng (kg)",

                border:OutlineInputBorder(),

              ),

            ),



            const SizedBox(height:30),



            SizedBox(

              width:double.infinity,


              child:ElevatedButton(

                onPressed:updateWeight,


                child:
                const Text(
                  "Lưu thay đổi",
                ),

              ),

            ),


          ],

        ),

      ),

    );

  }


}