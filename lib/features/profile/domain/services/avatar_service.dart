import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class AvatarService {
  final ImagePicker _picker = ImagePicker();

  /// Tamaño máximo permitido en bytes (5MB)
  static const int maxSizeInBytes = 5 * 1024 * 1024;

  /// Formatos de imagen permitidos
  static const List<String> allowedFormats = ['jpg', 'jpeg', 'png', 'webp'];

  /// Selecciona imagen desde la cámara
  Future<File?> pickFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image == null) return null;

      return await _processImage(File(image.path));
    } catch (e) {
      throw Exception('errorTakingPhoto');
    }
  }

  /// Selecciona imagen desde la galería
  Future<File?> pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image == null) return null;

      return await _processImage(File(image.path));
    } catch (e) {
      throw Exception('errorSelectingImage');
    }
  }

  /// Procesa y valida la imagen seleccionada
  Future<File> _processImage(File imageFile) async {
    // Validar formato
    final extension = imageFile.path.split('.').last.toLowerCase();
    if (!allowedFormats.contains(extension)) {
      throw Exception('invalidImageFormat');
    }

    // Validar tamaño
    final fileSize = await imageFile.length();
    if (fileSize > maxSizeInBytes) {
      throw Exception('imageTooLarge');
    }

    // Comprimir imagen si es necesario
    if (fileSize > 1024 * 1024) { // Si es mayor a 1MB, comprimir
      return await _compressImage(imageFile);
    }

    return imageFile;
  }

  /// Comprime la imagen para reducir su tamaño
  Future<File> _compressImage(File file) async {
    try {
      final dir = await getTemporaryDirectory();
      final targetPath = '${dir.path}/avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 85,
        minWidth: 1024,
        minHeight: 1024,
        format: CompressFormat.jpeg,
      );

      if (result == null) {
        throw Exception('errorCompressingImage');
      }

      return File(result.path);
    } catch (e) {
      throw Exception('errorCompressingImage');
    }
  }
}
