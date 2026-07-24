import 'package:flutter/material.dart';
import '../../language_notifier.dart';

class VaccineScheduleScreen extends StatefulWidget {
  const VaccineScheduleScreen({super.key});

  @override
  State<VaccineScheduleScreen> createState() => _VaccineScheduleScreenState();
}

class _VaccineScheduleScreenState extends State<VaccineScheduleScreen> {
  final List<Map<String, String>> _schedules = [
    {
      'petName': 'Milo',
      'vaccineName': 'Tiêm Vaccine Dại',
      'vaccineNameEn': 'Rabies Vaccine',
      'date': '01/06/2024',
      'note': 'Nhắc lại sau 1 năm',
      'noteEn': 'Repeat after 1 year',
    },
    {
      'petName': 'Bông',
      'vaccineName': 'Tiêm Vaccine 5 bệnh',
      'vaccineNameEn': '5-in-1 Vaccine',
      'date': '05/06/2024',
      'note': 'Mũi thứ 2',
      'noteEn': '2nd dose',
    },
  ];

  void _showAddVaccineDialog(bool isEnglish) {
    final petController = TextEditingController();
    final vaccineController = TextEditingController();
    final dateController = TextEditingController();
    final noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEnglish ? 'Add Vaccination Schedule' : 'Thêm lịch tiêm mới'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: petController,
                  decoration: InputDecoration(
                    labelText: isEnglish ? 'Pet Name' : 'Tên thú cưng',
                  ),
                ),
                TextField(
                  controller: vaccineController,
                  decoration: InputDecoration(
                    labelText: isEnglish ? 'Vaccine Name' : 'Tên loại Vaccine',
                  ),
                ),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: isEnglish ? 'Date (DD/MM/YYYY)' : 'Ngày tiêm (DD/MM/YYYY)',
                  ),
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
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              onPressed: () {
                if (petController.text.isNotEmpty && vaccineController.text.isNotEmpty) {
                  setState(() {
                    _schedules.add({
                      'petName': petController.text,
                      'vaccineName': vaccineController.text,
                      'vaccineNameEn': vaccineController.text,
                      'date': dateController.text.isEmpty ? '10/06/2024' : dateController.text,
                      'note': noteController.text,
                      'noteEn': noteController.text,
                    });
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isEnglish ? 'Vaccination schedule added!' : 'Đã thêm lịch tiêm thành công!',
                      ),
                    ),
                  );
                }
              },
              child: Text(isEnglish ? 'Save' : 'Lưu', style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, currentLang, child) {
        final isEnglish = currentLang == 'English';

        return Scaffold(
          appBar: AppBar(
            title: Text(isEnglish ? 'Vaccination Schedule' : 'Lịch tiêm phòng'),
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          body: _schedules.isEmpty
              ? Center(
                  child: Text(
                    isEnglish ? 'No vaccination schedule yet.' : 'Chưa có lịch tiêm phòng nào.',
                    style: const TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _schedules.length,
                  itemBuilder: (context, index) {
                    final item = _schedules[index];
                    final vaccine = isEnglish
                        ? (item['vaccineNameEn'] ?? item['vaccineName']!)
                        : item['vaccineName']!;
                    final note = isEnglish
                        ? (item['noteEn'] ?? item['note']!)
                        : item['note']!;

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
                          vaccine,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${isEnglish ? "Pet" : "Thú cưng"}: ${item['petName']} | $note',
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                            const SizedBox(height: 4),
                            Text(
                              item['date']!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddVaccineDialog(isEnglish),
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
