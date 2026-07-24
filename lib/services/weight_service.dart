import '../models/weight_model.dart';


class WeightService {


  static List<WeightModel> weights = [

    WeightModel(
      date: "01/06/2026",
      weight: "11.5 kg",
    ),

    WeightModel(
      date: "15/06/2026",
      weight: "12 kg",
    ),

    WeightModel(
      date: "01/07/2026",
      weight: "12.5 kg",
    ),

  ];



  static void addWeight(
      String date,
      String weight
  ){

    weights.add(

      WeightModel(
        date: date,
        weight: weight,
      ),

    );

  }

}