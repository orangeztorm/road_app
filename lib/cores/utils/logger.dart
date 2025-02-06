import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';

class LoggerHelper {
  static log(e, [s = '']) {
    // Don't log during tests or prod
    if (Platform.environment.containsKey('FLUTTER_TEST') && kReleaseMode) {
      return;
    }

    developer.log(e.toString());
    developer.log(s.toString());
  }
}
