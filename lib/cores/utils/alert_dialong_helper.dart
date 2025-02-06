import 'package:flutter/material.dart';

class AlertHelper {
  static void show({required BuildContext context, required Widget child}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: child,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}

