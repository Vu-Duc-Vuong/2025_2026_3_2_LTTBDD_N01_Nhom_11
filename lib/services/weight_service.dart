import '../models/weight_model.dart';


class WeightService {


  static final List<WeightModel> weightList = [

    WeightModel(
      petId: "1", // Lucky
      date: "01/06/2026",
      weight: "3.5 kg",
    ),

    WeightModel(
      petId: "1",
      date: "15/06/2026",
      weight: "3.6 kg",
    ),

    WeightModel(
      petId: "2", // Milo
      date: "01/06/2026",
      weight: "4.2 kg",
    ),

  ];



  static void addWeight(WeightModel weight){

    weightList.add(weight);

  }


}