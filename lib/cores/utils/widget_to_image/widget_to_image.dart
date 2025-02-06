import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

final class WidgetToImage {
  // static Future<void> sharePdfReceipt() async {
  //   Uint8List? imageBytes = await captureScreen(_globalKey);
  //   if (imageBytes != null) {
  //     File pdfFile = await createPdf(imageBytes);
  //
  //     await _shareFile(pdfFile);
  //   }
  // }

  static Future<void> shareImageReceipt(GlobalKey key) async {
    final BuildContext? context = key.currentContext;
    final boundary = context?.findRenderObject() as RenderRepaintBoundary;

    var image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List? imageBytes = byteData?.buffer.asUint8List();

    if (imageBytes != null) {
      File imageFile = await _saveImage(imageBytes);
      await _shareFile(imageFile);
    }
  }

  static Future<File> _saveImage(Uint8List imageBytes) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    final file = File(
      '$tempPath/receipt_${DateTime.now().millisecondsSinceEpoch}.png',
    );
    await file.writeAsBytes(imageBytes);
    return file;
  }

  static Future<void> _shareFile(File pdfFile) async {
    Share.shareXFiles(
      [XFile(pdfFile.path)],
      text: 'Here is the PDF of the screen.',
    );
  }
}
