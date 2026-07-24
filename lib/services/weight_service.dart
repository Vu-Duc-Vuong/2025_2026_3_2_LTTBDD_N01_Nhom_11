import '../models/weight_model.dart';


class WeightService {


  static final List<WeightModel> weightList = [

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



  static void addWeight(WeightModel weight){

    weightList.add(weight);

  }


}