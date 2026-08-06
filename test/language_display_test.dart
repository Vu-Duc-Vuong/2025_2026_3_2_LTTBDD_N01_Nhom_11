import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_project/utils/language_utils.dart';

void main() {
  group('language display helpers', () {
    test(
      'maps species to English labels while preserving original values for storage',
      () {
        expect(getPetSpeciesLabel('Chó', false), 'Chó');
        expect(getPetSpeciesLabel('Chó', true), 'Dog');
        expect(getPetSpeciesLabel('Mèo', true), 'Cat');
        expect(getPetSpeciesLabel('Khác', true), 'Other');
      },
    );

    test(
      'maps gender to English labels while preserving original values for storage',
      () {
        expect(getPetGenderLabel('Đực', false), 'Đực');
        expect(getPetGenderLabel('Đực', true), 'Male');
        expect(getPetGenderLabel('Cái', true), 'Female');
      },
    );

    test('normalizes species values regardless of language', () {
      expect(normalizePetSpeciesValue('Dog'), 'Chó');
      expect(normalizePetSpeciesValue('Cat'), 'Mèo');
      expect(normalizePetSpeciesValue('Other'), 'Khác');
      expect(normalizePetSpeciesValue('Chó'), 'Chó');
    });

    test('normalizes gender values regardless of language', () {
      expect(normalizePetGenderValue('Male'), 'Đực');
      expect(normalizePetGenderValue('Female'), 'Cái');
      expect(normalizePetGenderValue('Đực'), 'Đực');
    });
  });
}
