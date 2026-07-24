class Pet {
  String id;
  String name;
  String species;
  String breed;
  String gender;
  String birthDate;
  String color;
  double weight;
  String ownerName;
  String phone;
  String note;
  String imagePath; // Thêm trường đường dẫn ảnh

  Pet({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.gender,
    required this.birthDate,
    required this.color,
    required this.weight,
    required this.ownerName,
    required this.phone,
    this.note = '',
    this.imagePath = '',
  });
}
