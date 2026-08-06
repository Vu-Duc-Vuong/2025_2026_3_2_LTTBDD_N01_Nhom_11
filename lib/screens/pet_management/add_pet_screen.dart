import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // Thêm thư viện này để check kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/pet_model.dart';
import '../../utils/language_utils.dart';
import '../../language_notifier.dart';

class AddEditPetScreen extends StatefulWidget {
  final Pet? pet;

  const AddEditPetScreen({super.key, this.pet});

  @override
  State<AddEditPetScreen> createState() => _AddEditPetScreenState();
}

class _AddEditPetScreenState extends State<AddEditPetScreen> {
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _colorController = TextEditingController();
  final _weightController = TextEditingController();
  final _ownerController = TextEditingController();
  final _phoneController = TextEditingController();
  final _noteController = TextEditingController();

  String selectedSpecies = 'Chó';
  String selectedGender = 'Đực';
  String selectedDateStr = 'Chọn ngày sinh';

  // Biến lưu đường dẫn ảnh
  String? _selectedImagePath;
  Uint8List? _webImageBytes; // Lưu byte ảnh riêng cho Web
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.pet != null) {
      _nameController.text = widget.pet!.name;
      _breedController.text = widget.pet!.breed;
      _colorController.text = widget.pet!.color;
      _weightController.text = widget.pet!.weight > 0
          ? widget.pet!.weight.toString()
          : '';
      _ownerController.text = widget.pet!.ownerName;
      _phoneController.text = widget.pet!.phone;
      _noteController.text = widget.pet!.note;

      selectedSpecies = normalizePetSpeciesValue(widget.pet!.species);
      selectedGender = normalizePetGenderValue(widget.pet!.gender);
      selectedDateStr = widget.pet!.birthDate;
      _selectedImagePath = widget.pet!.imagePath.isNotEmpty
          ? widget.pet!.imagePath
          : null;
    }
  }

  // Hàm chọn ảnh từ Thư viện hoặc Máy ảnh
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      if (kIsWeb) {
        // Đọc dữ liệu byte nếu chạy trên Web
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _webImageBytes = bytes;
          _selectedImagePath = pickedFile.path;
        });
      } else {
        // Nếu chạy trên Android / iOS
        setState(() {
          _selectedImagePath = pickedFile.path;
        });
      }
    }
  }

  // BottomSheet cho phép chọn nguồn ảnh
  void _showImageSourceModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.teal),
                title: const Text('Chọn từ thư viện'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.teal),
                title: const Text('Chụp ảnh mới'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Hàm hiển thị provider ảnh tương thích nhiều nền tảng
  ImageProvider? _getImageProvider() {
    if (kIsWeb) {
      if (_webImageBytes != null) {
        return MemoryImage(_webImageBytes!);
      }
      if (_selectedImagePath != null && _selectedImagePath!.isNotEmpty) {
        return NetworkImage(_selectedImagePath!);
      }
    } else {
      if (_selectedImagePath != null && _selectedImagePath!.isNotEmpty) {
        return FileImage(File(_selectedImagePath!));
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.pet != null;
    final isEnglish = languageNotifier.value == 'English';
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          isEdit
              ? (isEnglish ? 'Edit Pet Information' : 'Sửa thông tin thú cưng')
              : (isEnglish ? 'Add Pet' : 'Thêm thú cưng'),
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            theme.appBarTheme.backgroundColor ?? colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Widget Avatar hiển thị ảnh đã chọn
            Center(
              child: GestureDetector(
                onTap: _showImageSourceModal,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: colorScheme.surfaceVariant,
                          backgroundImage: _getImageProvider(),
                          child:
                              (_webImageBytes == null &&
                                  _selectedImagePath == null)
                              ? Icon(
                                  Icons.pets,
                                  size: 40,
                                  color: colorScheme.onSurfaceVariant,
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xff00897B),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      (_webImageBytes == null && _selectedImagePath == null)
                          ? (isEnglish ? 'Add photo' : 'Thêm ảnh')
                          : (isEnglish ? 'Change photo' : 'Đổi ảnh'),
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            buildTextField(
              isEnglish ? 'Pet name *' : 'Tên thú cưng *',
              _nameController,
              isEnglish ? 'Enter name' : 'Nhập tên',
            ),
            const SizedBox(height: 15),

            buildDropdown(
              isEnglish ? 'Species *' : 'Loài *',
              selectedSpecies,
              ['Chó', 'Mèo', 'Khác'],
              (val) {
                setState(() => selectedSpecies = val!);
              },
            ),
            const SizedBox(height: 15),

            buildTextField(
              isEnglish ? 'Breed' : 'Giống',
              _breedController,
              isEnglish ? 'Enter breed' : 'Nhập giống',
            ),
            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: buildDropdown(
                    isEnglish ? 'Gender *' : 'Giới tính *',
                    selectedGender,
                    ['Đực', 'Cái'],
                    (val) {
                      setState(() => selectedGender = val!);
                    },
                    isEnglish: isEnglish,
                    isGender: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEnglish ? 'Date of birth *' : 'Ngày sinh *',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5),
                      InkWell(
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2010),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() {
                              selectedDateStr =
                                  "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: colorScheme.outlineVariant,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedDateStr,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: selectedDateStr.contains('/')
                                      ? colorScheme.onSurface
                                      : colorScheme.onSurfaceVariant,
                                ),
                              ),
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 16,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            buildTextField(
              isEnglish ? 'Coat color' : 'Màu lông',
              _colorController,
              isEnglish ? 'Enter coat color' : 'Nhập màu lông',
            ),
            const SizedBox(height: 15),

            buildTextField(
              isEnglish ? 'Initial weight (kg)' : 'Cân nặng ban đầu (kg)',
              _weightController,
              isEnglish ? 'Enter weight' : 'Nhập cân nặng',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15),

            buildTextField(
              isEnglish ? 'Owner *' : 'Chủ sở hữu *',
              _ownerController,
              isEnglish ? 'Enter owner name' : 'Nhập tên chủ sở hữu',
            ),
            const SizedBox(height: 15),

            buildTextField(
              isEnglish ? 'Phone number *' : 'Số điện thoại *',
              _phoneController,
              isEnglish ? 'Enter phone number' : 'Nhập số điện thoại',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 15),

            buildTextField(
              isEnglish ? 'Note' : 'Ghi chú',
              _noteController,
              "Nhập ghi chú",
              maxLines: 3,
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_nameController.text.trim().isEmpty) return;

                  Pet resultPet = Pet(
                    id: isEdit
                        ? widget.pet!.id
                        : DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _nameController.text.trim(),
                    species: selectedSpecies,
                    breed: _breedController.text.trim(),
                    gender: selectedGender,
                    birthDate: selectedDateStr,
                    color: _colorController.text.trim(),
                    weight: double.tryParse(_weightController.text) ?? 0.0,
                    ownerName: _ownerController.text.trim(),
                    phone: _phoneController.text.trim(),
                    note: _noteController.text.trim(),
                    imagePath: _selectedImagePath ?? '',
                  );

                  Navigator.pop(context, resultPet);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff00897B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  isEdit
                      ? (isEnglish ? 'Update' : 'Cập nhật')
                      : (isEnglish ? 'Save' : 'Lưu'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(color: colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 13,
            ),
            fillColor: colorScheme.surface,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDropdown(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged, {
    bool isEnglish = false,
    bool isSpecies = false,
    bool isGender = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    isSpecies
                        ? getPetSpeciesLabel(e, isEnglish)
                        : isGender
                        ? getPetGenderLabel(e, isEnglish)
                        : e,
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            fillColor: colorScheme.surface,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
          ),
        ),
      ],
    );
  }
}
