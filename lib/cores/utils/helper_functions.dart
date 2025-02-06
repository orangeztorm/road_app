// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:road_app/cores/__cores.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

String getMimeType(String filePath) {
  final String? mimeType = lookupMimeType(filePath);
  return mimeType ?? 'application/octet-stream'; // Default MIME type
}

String generateReferenceNumber() {
  final Random random = Random();
  final StringBuffer reference = StringBuffer();

  for (int i = 0; i < 16; i++) {
    reference.write(random.nextInt(16)); // Generate a digit (0-9)
  }

  return reference.toString();
}

String getInitials(String? name) {
  try {
    if (name == null || name.isEmpty) {
      return AppStrings.na;
    }

    final words = name.trim().split(' ');
    return words.take(2).map((word) => word[0].toUpperCase()).join();
  } catch (e) {
    return name?[0] ?? 'N/A';
  }
}

int calculateDynamicPercentage(
  List<bool> values,
) {
  if (values.isEmpty) return 1; // Prevent division by zero
  int trueCount = values.where((v) => v).length;
  final value = ((trueCount / values.length) * 100).round();
  if (value == 0) return 1;
  return value;
}

Future<MapEntry<String, http.MultipartFile>> toFileMapEntry(
    XFile file, String fieldName) async {
  final mimeTypeData = lookupMimeType(file.path)?.split('/');
  final fileMultipart = await http.MultipartFile.fromPath(
    fieldName,
    file.path,
    filename: basename(file.path),
    contentType: mimeTypeData != null
        ? MediaType(mimeTypeData[0], mimeTypeData[1])
        : null,
  );
  return MapEntry(fieldName, fileMultipart);
}

Future<XFile?> pickImage(ImageSource source) async {
  final picker = ImagePicker();
  return await picker.pickImage(source: source);
}

/// Helper function to check if the image size is less than or equal to 1.5MB
Future<bool> isImageSizeUpTo1_5MB(XFile imageFile) async {
  // Convert the 1.5MB threshold to an integer
  int maxSizeInBytes = (1.5 * 1024 * 1024).toInt(); // 1.5MB in bytes
  int fileSize = await imageFile.length(); // Get file size in bytes (async)
  return fileSize <= maxSizeInBytes;
}

bool isEntryNullOrHasNullValues(MapEntry<String, String>? entry) =>
    entry == null || entry.key.isEmpty || entry.value.isEmpty;
