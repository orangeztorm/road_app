import 'dart:io';

import 'package:road_app/app/__app.dart';
import 'package:road_app/firebase_options.dart';
import 'package:road_app/http_overides.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:beam/app/__app.dart';

// import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set global HttpOverrides
  HttpOverrides.global = MyHttpOverrides();

  await dotenv.load(fileName: ".env");
  Locator.init();
  await clearCache();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const OverlaySupport.global(child: MyApp()),
  );
}

Future<void> clearCache() async {
  final prefs = await SharedPreferences.getInstance();

  if (prefs.getBool('first_run') ?? true) {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.deleteAll();
    prefs.setBool('first_run', false);
  }
}
