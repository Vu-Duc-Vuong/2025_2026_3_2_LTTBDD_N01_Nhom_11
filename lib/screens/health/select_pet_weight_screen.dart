import 'package:flutter/material.dart';
import '../../models/pet_model.dart';
import 'health_screen.dart';


class SelectPetWeightScreen extends StatelessWidget {

  final List<Pet> petList;


  const SelectPetWeightScreen({
    super.key,
    required this.petList,
  });



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Chọn thú cưng",
        ),
      ),


      body: ListView.builder(

        padding: const EdgeInsets.all(16),

        itemCount: petList.length,


        itemBuilder: (context,index){

          final pet = petList[index];


          return Card(

            child: ListTile(

              leading: const Icon(
                Icons.pets,
                size:40,
              ),


              title: Text(
                pet.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),


              subtitle: Text(
                "${pet.species} - ${pet.breed}",
              ),


              trailing: Text(
                "${pet.weight} kg",
              ),


              onTap: (){


                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) => HealthScreen(
                      pet: pet,
                    ),

                  ),

                );


              },


            ),

          );


        },

      ),

    );

  }

}