import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/__features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:road_app/features/auth/presentation/pages/authority/cav_schedule_page.dart';
import 'package:road_app/features/auth/presentation/pages/user/notification_page.dart';
import 'package:road_app/features/other_pages/notification_settings_page.dart';
import 'package:road_app/features/auth/presentation/pages/authority/road_surface_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, Widget? child) {
        return MaterialApp(
          title: AppStrings.appName,
          themeMode: ThemeMode.light,
          theme: ThemeClass.lightTheme,
          darkTheme: ThemeClass.darkTheme,
          initialRoute: LoginPage.routeName,
          onGenerateRoute: RouteGenerator.generateRoute,
          navigatorKey: AppRouter.instance.navigatorKey,
          scaffoldMessengerKey: Toast.key,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
