import 'package:flutter/material.dart';
import '../../language_notifier.dart';
import '../../services/vaccination_service.dart';
import '../../models/vaccination_model.dart';

class VaccineScheduleScreen extends StatefulWidget {
  final List<String> petNames;

  const VaccineScheduleScreen({super.key, this.petNames = const []});

  @override
  State<VaccineScheduleScreen> createState() => _VaccineScheduleScreenState();
}

class _VaccineScheduleScreenState extends State<VaccineScheduleScreen> {
  List<String> _buildAvailablePetNames() {
    final fromScreen = widget.petNames;
    final fromSchedule = VaccinationService.vaccinationList
        .map((item) => item.petName)
        .where((name) => name.trim().isNotEmpty)
        .toList();

    final merged = <String>{};
    merged.addAll(fromScreen);
    merged.addAll(fromSchedule);
    return merged.toList();
  }

  void _showVaccineDialog(
    bool isEnglish, {
    int? index,
    VaccinationModel? existing,
  }) {
    final petNames = _buildAvailablePetNames();
    final vaccineController = TextEditingController();
    final dateController = TextEditingController();
    final noteController = TextEditingController();
    vaccineController.text = existing?.name ?? '';
    dateController.text = existing?.date ?? '';
    noteController.text = existing?.note ?? '';

    String status = existing?.status ?? "Chưa tiêm";
    String? selectedPetName = existing?.petName;
    if (selectedPetName == null && petNames.isNotEmpty) {
      selectedPetName = petNames.first;
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                index == null
                    ? (isEnglish
                          ? 'Add Vaccination Schedule'
                          : 'Thêm lịch tiêm mới')
                    : (isEnglish
                          ? 'Edit Vaccination Schedule'
                          : 'Sửa lịch tiêm'),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedPetName,
                      decoration: InputDecoration(
                        labelText: isEnglish ? 'Pet Name' : 'Tên thú cưng',
                        border: const OutlineInputBorder(),
                      ),
                      items: petNames
                          .map(
                            (petName) => DropdownMenuItem(
                              value: petName,
                              child: Text(petName),
                            ),
                          )
                          .toList(),
                      onChanged: petNames.isEmpty
                          ? null
                          : (value) {
                              setDialogState(() {
                                selectedPetName = value;
                              });
                            },
                    ),
                    if (petNames.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          isEnglish
                              ? 'No pets found. Please add pets first.'
                              : 'Chưa có thú cưng. Vui lòng thêm thú cưng trước.',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: vaccineController,
                      decoration: InputDecoration(
                        labelText: isEnglish
                            ? 'Vaccine Name'
                            : 'Tên loại Vaccine',
                      ),
                    ),
                    TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                        labelText: isEnglish
                            ? 'Date (DD/MM/YYYY)'
                            : 'Ngày tiêm (DD/MM/YYYY)',
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: status,
                      decoration: InputDecoration(
                        labelText: isEnglish ? 'Status' : 'Trạng thái',
                        border: const OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "Đã tiêm",
                          child: Text("Đã tiêm"),
                        ),
                        DropdownMenuItem(
                          value: "Chưa tiêm",
                          child: Text("Chưa tiêm"),
                        ),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          status = value!;
                        });
                      },
                    ),
                    TextField(
                      controller: noteController,
                      decoration: InputDecoration(
                        labelText: isEnglish ? 'Note' : 'Ghi chú',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(isEnglish ? 'Cancel' : 'Hủy'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: () {
                    if (selectedPetName != null &&
                        vaccineController.text.trim().isNotEmpty) {
                      final vaccination = VaccinationModel(
                        petName: selectedPetName!,
                        name: vaccineController.text.trim(),
                        date: dateController.text.trim().isEmpty
                            ? '10/06/2024'
                            : dateController.text.trim(),
                        doctor: existing?.doctor ?? "Dr. An",
                        status: status,
                        repeatDate: existing?.repeatDate ?? "01/01/2027",
                        note: noteController.text.trim(),
                      );

                      if (index == null) {
                        VaccinationService.addVaccination(vaccination);
                      } else {
                        VaccinationService.updateVaccinationAt(
                          index,
                          vaccination,
                        );
                      }

                      setState(() {});
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            index == null
                                ? (isEnglish
                                      ? 'Vaccination schedule added!'
                                      : 'Đã thêm lịch tiêm thành công!')
                                : (isEnglish
                                      ? 'Vaccination schedule updated!'
                                      : 'Đã cập nhật lịch tiêm thành công!'),
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    isEnglish ? 'Save' : 'Lưu',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _confirmDelete(int index, bool isEnglish) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEnglish ? 'Delete Schedule' : 'Xóa lịch tiêm'),
        content: Text(
          isEnglish
              ? 'Are you sure you want to delete this schedule?'
              : 'Bạn có chắc muốn xóa lịch tiêm này?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isEnglish ? 'Cancel' : 'Hủy'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              VaccinationService.removeVaccinationAt(index);
              setState(() {});
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isEnglish
                        ? 'Vaccination schedule deleted!'
                        : 'Đã xóa lịch tiêm thành công!',
                  ),
                ),
              );
            },
            child: Text(
              isEnglish ? 'Delete' : 'Xóa',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, currentLang, child) {
        final isEnglish = currentLang == 'English';
        final vaccinationList = VaccinationService.vaccinationList;

        return Scaffold(
          appBar: AppBar(
            title: Text(isEnglish ? 'Vaccination Schedule' : 'Lịch tiêm phòng'),
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          body: vaccinationList.isEmpty
              ? Center(
                  child: Text(
                    isEnglish
                        ? 'No vaccination schedule yet.'
                        : 'Chưa có lịch tiêm phòng nào.',
                    style: const TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: vaccinationList.length,
                  itemBuilder: (context, index) {
                    final item = vaccinationList[index];

                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          child: Icon(Icons.vaccines, color: Colors.white),
                        ),
                        title: Text(
                          item.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Thú cưng: ${item.petName}"),
                            Text("Ngày tiêm: ${item.date}"),
                            Text("Bác sĩ: ${item.doctor}"),
                            Text("Trạng thái: ${item.status}"),
                            Text("Tiêm lại: ${item.repeatDate}"),
                            if (item.note.isNotEmpty)
                              Text("Ghi chú: ${item.note}"),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              tooltip: isEnglish ? 'Edit' : 'Sửa',
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: Colors.teal,
                              ),
                              onPressed: () => _showVaccineDialog(
                                isEnglish,
                                index: index,
                                existing: item,
                              ),
                            ),
                            IconButton(
                              tooltip: isEnglish ? 'Delete' : 'Xóa',
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () => _confirmDelete(index, isEnglish),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showVaccineDialog(isEnglish),
            backgroundColor: Colors.deepPurple,
            icon: const Icon(Icons.add, color: Colors.white),
            label: Text(
              isEnglish ? 'Add Schedule' : 'Thêm lịch tiêm',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
