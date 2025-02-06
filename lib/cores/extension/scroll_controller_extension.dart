import 'package:flutter/widgets.dart';

extension ScrollControllerExtension on ScrollController {
  void addEndScrollListener(VoidCallback callback) {
    addListener(() {
      if (position.pixels >= position.maxScrollExtent - 20) {
        callback();
      }
    });
  }
}
