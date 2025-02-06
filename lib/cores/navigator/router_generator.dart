import 'dart:io';

import 'package:road_app/features/__features.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/auth/presentation/pages/authority/authority_login_page.dart';
import 'package:road_app/features/auth/presentation/pages/authority/camera_page.dart';
import 'package:road_app/features/auth/presentation/pages/login/welcome_page.dart';
import 'package:road_app/features/auth/presentation/pages/authority/cav_schedule_page.dart';
import 'package:road_app/features/auth/presentation/pages/user/notification_page.dart';
import 'package:road_app/features/other_pages/notification_settings_page.dart';
import 'package:road_app/features/auth/presentation/pages/authority/road_surface_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      // case IntroScreen.routeName:
      //   return pageRoute(const IntroScreen());

      case LoginPage.routeName:
        return pageRoute(const LoginPage());

      case WelcomePage.routeName:
        return pageRoute(const WelcomePage());

      case AuthorityLoginPage.routeName:
        return pageRoute(const AuthorityLoginPage());

      case NotificationPage.routeName:
        return pageRoute(const NotificationPage());

      case NotificationSettingsPage.routeName:
        return pageRoute(const NotificationSettingsPage());

      case CavSchedulePage.routeName:
        return pageRoute(const CavSchedulePage());

      case RoadSurfacePage.routeName:
        return pageRoute(const RoadSurfacePage());

      case CameraCapturePage.routeName:
        return pageRoute(const CameraCapturePage());

      default:
        return errorRoute();
    }
  }

  static PageRoute pageRoute(Widget page) {
    if (Platform.isIOS) {
      return CupertinoPageRoute(builder: (_) => page);
    }

    return MaterialPageRoute(builder: (_) => page);
  }
}
