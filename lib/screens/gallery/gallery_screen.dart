import 'package:flutter/material.dart';
import '../../language_notifier.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List<Map<String, String>> _photos = [
    {
      'title': 'Milo dạo công viên',
      'titleEn': 'Milo at the park',
      'url': 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=500',
    },
    {
      'title': 'Lucky tắm nắng',
      'titleEn': 'Lucky sunbathing',
      'url': 'https://images.unsplash.com/photo-1543466835-00a7907e9de1?w=500',
    },
    {
      'title': 'Bông sinh nhật 1 tuổi',
      'titleEn': 'Bong\'s 1st Birthday',
      'url': 'https://images.unsplash.com/photo-1533738363-b7f9aef128ce?w=500',
    },
    {
      'title': 'Giờ đi ngủ',
      'titleEn': 'Bedtime',
      'url': 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?w=500',
    },
  ];

  void _showAddPhotoDialog(bool isEnglish) {
    final titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEnglish ? 'Add New Photo' : 'Thêm ảnh mới'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: isEnglish ? 'Photo Title' : 'Tiêu đề ảnh',
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.image),
                label: Text(isEnglish ? 'Choose from Gallery' : 'Chọn từ thiết bị'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(isEnglish ? 'Cancel' : 'Hủy'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  setState(() {
                    _photos.add({
                      'title': titleController.text,
                      'titleEn': titleController.text,
                      'url': 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=500',
                    });
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isEnglish ? 'Photo added successfully!' : 'Đã thêm ảnh thành công!',
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
            title: Text(isEnglish ? 'Pet Photo Gallery' : 'Thư viện ảnh thú cưng'),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              itemCount: _photos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                final photo = _photos[index];
                final title = isEnglish
                    ? (photo['titleEn'] ?? photo['title']!)
                    : photo['title']!;

                return Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.network(
                          photo['url']!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.pets, size: 40, color: Colors.grey),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddPhotoDialog(isEnglish),
            backgroundColor: Colors.redAccent,
            icon: const Icon(Icons.add_a_photo, color: Colors.white),
            label: Text(
              isEnglish ? 'Add Photo' : 'Thêm ảnh',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
