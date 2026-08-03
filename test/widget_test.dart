import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_project/services/vaccination_service.dart';

void main() {
  test('returns upcoming vaccination reminders sorted by date', () {
    final reminders = VaccinationService.getUpcomingVaccinations(
      now: DateTime(2026, 8, 3),
    );

    expect(reminders.length, 1);
    expect(reminders.first.name, 'Vaccine Care');
    expect(reminders.first.petName, 'Lucky');
  });
}
