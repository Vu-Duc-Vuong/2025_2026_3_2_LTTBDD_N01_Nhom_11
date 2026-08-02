import '../models/vaccination_model.dart';

class VaccinationService {
  static final List<VaccinationModel> vaccinationList = [
    VaccinationModel(
      petName: "Milo",
      name: "Vaccine phòng dại",
      date: "10/03/2026",
      doctor: "Dr. An",
      status: "Đã tiêm",
      repeatDate: "10/03/2027",
      note: "Nhắc lại sau 1 năm",
    ),

    VaccinationModel(
      petName: "Bông",
      name: "Vaccine 5 bệnh",
      date: "15/04/2026",
      doctor: "Dr. An",
      status: "Đã tiêm",
      repeatDate: "15/04/2027",
      note: "Mũi thứ 2",
    ),

    VaccinationModel(
      petName: "Lucky",
      name: "Vaccine Care",
      date: "20/08/2026",
      doctor: "Dr. Bình",
      status: "Chưa tiêm",
      repeatDate: "20/08/2027",
      note: "",
    ),
  ];

  static void addVaccination(VaccinationModel vaccination) {
    vaccinationList.add(vaccination);
  }

  static void updateVaccinationAt(int index, VaccinationModel vaccination) {
    if (index < 0 || index >= vaccinationList.length) return;
    vaccinationList[index] = vaccination;
  }

  static void removeVaccinationAt(int index) {
    if (index < 0 || index >= vaccinationList.length) return;
    vaccinationList.removeAt(index);
  }
}
