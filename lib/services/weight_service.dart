import '../models/weight_model.dart';


class WeightService {


  static final List<WeightModel> weightList = [

    WeightModel(
      petId: "1",
      date: "01/06/2026",
      weight: "11.5 kg",
    ),

    WeightModel(
      petId: "1",
      date: "15/06/2026",
      weight: "12 kg",
    ),

    WeightModel(
      petId: "2",
      date: "01/07/2026",
      weight: "12.5 kg",
    ),

  ];



  static void addWeight(WeightModel weight){

    weightList.add(weight);

  }


}