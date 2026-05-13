import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadImageService {
  final picker = ImagePicker();
  final supabase = Supabase.instance.client;

  Future<File?> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return null;

    return File(picked.path);
  }

  Future<String?> uploadImage(File file) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();

    await supabase.storage.from('images').upload(fileName, file);

    final url = supabase.storage.from('images').getPublicUrl(fileName);

    return url;
  }
}
