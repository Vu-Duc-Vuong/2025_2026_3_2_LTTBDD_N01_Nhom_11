import '../models/vaccination_model.dart';


class VaccinationService {


  static final List<VaccinationModel> vaccinationList = [


    VaccinationModel(
      name: "Vaccine phòng dại",
      date: "10/03/2026",
      status: "Đã tiêm",
    ),


    VaccinationModel(
      name: "Vaccine 5 bệnh",
      date: "15/04/2026",
      status: "Đã tiêm",
    ),


    VaccinationModel(
      name: "Vaccine Care",
      date: "20/08/2026",
      status: "Chưa tiêm",
    ),


  ];



  static void addVaccination(
      VaccinationModel vaccination
  ){

    vaccinationList.add(vaccination);

  }


}