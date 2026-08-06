String normalizePetSpeciesValue(String value) {
  final normalized = value.trim().toLowerCase();

  switch (normalized) {
    case 'dog':
    case 'chó':
    case 'cho':
      return 'Chó';
    case 'cat':
    case 'mèo':
    case 'meo':
      return 'Mèo';
    case 'other':
    case 'khác':
    case 'khac':
      return 'Khác';
    default:
      return value;
  }
}

String getPetSpeciesLabel(String value, bool isEnglish) {
  if (!isEnglish) return value;

  switch (value) {
    case 'Chó':
      return 'Dog';
    case 'Mèo':
      return 'Cat';
    case 'Khác':
      return 'Other';
    default:
      return value;
  }
}

String normalizePetGenderValue(String value) {
  final normalized = value.trim().toLowerCase();

  switch (normalized) {
    case 'male':
    case 'đực':
    case 'duc':
      return 'Đực';
    case 'female':
    case 'cái':
    case 'cai':
      return 'Cái';
    default:
      return value;
  }
}

String getPetGenderLabel(String value, bool isEnglish) {
  if (!isEnglish) return value;

  switch (value) {
    case 'Đực':
      return 'Male';
    case 'Cái':
      return 'Female';
    default:
      return value;
  }
}

String getPetStatusLabel(String value, bool isEnglish) {
  if (!isEnglish) return value;

  switch (value) {
    case 'Đã tiêm':
      return 'Vaccinated';
    case 'Chưa tiêm':
      return 'Not vaccinated';
    default:
      return value;
  }
}
