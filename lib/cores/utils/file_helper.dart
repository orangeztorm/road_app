// import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class FileHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<XFile?> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    return image;
  }

  // static Future<XFile?> takePicture() async {
  //   // if (kDebugMode && Platform.isIOS) {
  //   if (kDebugMode) {
  //     return await pickImage();
  //   }

  //   final XFile? video = await _picker.pickImage(source: ImageSource.camera);
  //   return video?.path;
  // }
}
