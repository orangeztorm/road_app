import 'package:flutter/foundation.dart';

import '../../app/env.dart';
import '../../app/locator.dart';

class ApiEndpoints {
  // static const String _versionOne = '/api/v1';
  // static const String _versionTwo = '/api/v2';
  // static const String _versionThree = '/api/v3';
  // static const String _versionFour = '/api/v4';
  // static const String _versionFive = '/api/v5';
  // static const String _versionSix = '/api/v6';
  // static const String _versionSeven = '/api/v7';

  static const _isDebug = kReleaseMode;
  // kDebugMode;

  static final String _baseUrl = (() {
    if (_isDebug) {
      return getIt<ENV>().apiBaseUrl;
    } else {
      return getIt<ENV>().apiBaseUrl;
    }
  })();

  // static final String _baseUrlV1 = (() {
  // if (_isDebug) {
  // return "${getIt<ENV>().apiBaseUrl}$_versionOne";
  // } else {
  //   return "${getIt<ENV>().prodApiBaseUrl}$_versionOne";
  // }
  // })();

  // static final String _baseUrlV2 = (() {
  //   if (_isDebug) {
  //     return "${getIt<ENV>().apiBaseUrl}$_versionTwo";
  //   } else {
  //     return "${getIt<ENV>().apiBaseUrl}$_versionTwo";
  //   }
  // })();

  String get baseUrl => 'https://pothole-production.up.railway.app';

  // String get baseUrlV2 => _baseUrlV2;

  // --------------------------------------
  static final String signIn = '$_baseUrl/api/v1.0.0/auth/admin/login';

  // admin
  static final String adminLogin = '$_baseUrl/api/v1.0.0/auth/admin/login';
  static final String adminLogout = '$_baseUrl/api/v1.0.0/auth/admin/logout';
  static final String adminChangePassword =
      '$_baseUrl/api/v1.0.0/auth/admin/change-password';
  static final String adminProfile = '$_baseUrl/api/v1.0.0/admin/profile/me';
  static final String potholesDetect =
      '$_baseUrl/api/v1.0.0/admin/portholes/detect';
  static final String potholesList = '$_baseUrl/api/v1.0.0/admin/portholes/all';
  static String assignTeam(id) =>
      '$_baseUrl/api/v1.0.0/admin/portholes/$id/assign-team';
  static final String cavSchedules =
      '$_baseUrl/api/v1.0.0/admin/cav-schedules/all';
  static final String addToSchedule =
      '$_baseUrl/api/v1.0.0/admin/cav-schedules';
  static String completePothole(id) =>
      '$_baseUrl/api/v1.0.0/admin/cav-schedules/pothole/$id/complete';

  // user
  static final String userSignup = '$_baseUrl/api/v1.0.0/auth/user/signup';
  static final String userSignin = '$_baseUrl/api/v1.0.0/auth/user/login';
  static final String nearbyPotholes =
      '$_baseUrl/api/v1.0.0/user/portholes/nearby';

  // teams
  static final String allTeams = '$_baseUrl/api/v1.0.0/admin/teams/all';
  static final String allAdmins = '$_baseUrl/api/v1.0.0/admin';
  static final String createAdmin = '$_baseUrl/api/v1.0.0/admin';
  static final String createTeams = '$_baseUrl/api/v1.0.0/admin/teams';
  static final String updateTeams = '$_baseUrl/api/v1.0.0/admin/teams';
  static final String report =
      '$_baseUrl/api/v1.0.0/admin/portholes/analytics/report';
  static String completePotholeAssesment(id) =>
      '$_baseUrl/api/v1.0.0/cav-schedules/pothole/$id/complete';
}



// 1100035588
// debit - bene color - red
// credit sender - color - green
// charge -- service fee -  color red

// compression
// if more than 100kb. reject the image


// credit - incoming --- from -> bene -> to -> me
// debit - outgoing --- from -> me -> to -> bene

// accestoken  valid for 10 min once inside the app
// efresh token valid for 30 min.
// refresh token ruturn an erro just log the user out.



// 08123902784
// 07016348143
// 22185847818


//09093591782
//07082157436

//08023545942  joy quidax