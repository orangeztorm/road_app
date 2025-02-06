import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

import '../exception/base_exception.dart';

abstract class AuthLocalStorageDataSource {
  Future<void> saveToken(String token);

  Future<void> saveRefreshToken(String refreshToken);

  Future<String?> getToken();

  Future<String?> getRefreshToken();

  Future<void> clearToken();

  Future<void> saveLoginData({
    required String pin,
    required String phone,
    required String hashedPin,
    required bool toggleBiometrics,
  });

  Future<AuthLocallySavedDetails?> getSavedLoginData();

  Future<bool> checkIfLoginDataIsSaved();

  Future<bool> toggleBiometric(bool value);

  Future<bool> checkBiometricToggleState();

  Future<bool> toggleDarkMode(bool value);

  Future<bool> toggleAmountVisibility(bool value);

  Future<bool> checkAmountVisibilityState();

  Future<bool> checkDarkModeToggleState();

  void clearLoginData();

  Future<bool> canUseThumbPrint();

  Future<bool> authenticateWithBioMetric();

  Future<bool> canUseBiometrics();

  Future<bool> isNotFirstTimeUsingApp();

  Future<void> savePattern(String pattern);

  Future<bool?> checkPattern(String pattern);

  Future<String?> getSavedPattern();
}

class AuthLocalStorageDataSourceImp implements AuthLocalStorageDataSource {
  final FlutterSecureStorage storage;
  final LocalAuthentication localAuth;

  const AuthLocalStorageDataSourceImp({
    required this.storage,
    required this.localAuth,
  });

  final String _isNotFirstTimeKey = 'IsNotFirstTimeUsingApp';
  final String _token = 'Token';
  final String _refreshToken = 'RefreshToken';
  final String _pattern = 'Pattern';
  final String _loginDetailsKey = 'LoginDetailsKey';
  final String _bioMetricStatus = 'BoiMetricStatus';
  final String _darkModeStatus = 'DarkModeStatus';
  final String _amountVisibility = 'AmountVisibility';

  @override
  Future<bool> canUseThumbPrint() async {
    final bool canUseBiometrics = await localAuth.canCheckBiometrics;
    final bool isDeviceSupported = await localAuth.isDeviceSupported();
    final bool canAuthenticate = canUseBiometrics || isDeviceSupported;

    return canAuthenticate;
  }

  @override
  Future<bool> authenticateWithBioMetric() async {
    try {
      final bool didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate to continue',
      );
      return didAuthenticate;
    } on PlatformException catch (e) {
      throw BaseFailures(message: 'Failed to authenticate: ${e.message}');
    } catch (e) {
      throw BaseFailures(message: 'An unknown error occurred: ${e.toString()}');
    }
  }
  // Future<bool> authenticateWithBioMetric() async {
  //   try {
  //     final bool didAuthenticate = await localAuth.authenticate(
  //       localizedReason: 'Please authenticate continue',
  //     );

  //     return didAuthenticate;
  //   } on PlatformException {
  //     throw const BaseFailures(message: 'Failed to authenticate');
  //   }
  // }

  @override
  Future<void> saveLoginData({
    required String pin,
    required String phone,
    required String hashedPin,
    required bool toggleBiometrics,
  }) async {
    final Map data = {
      'pin': pin,
      'phone': phone,
      'hasdhedPin': hashedPin,
    };

    final String value = json.encode(data);
    toggleBiometric(toggleBiometrics);

    await storage.write(key: _loginDetailsKey, value: value);
  }

  @override
  Future<AuthLocallySavedDetails?> getSavedLoginData() async {
    // final bool authenticate = await authenticateWithBioMetric();
    // if (!authenticate) {
    //   throw const BaseFailures(message: 'Authentication Failed');
    // }

    try {
      final String? value = await storage.read(key: _loginDetailsKey);

      if (value == null) {
        const BaseFailures message = BaseFailures(
          message: 'No User Was Found Or A change password operation was '
              'preform, Please Login With Email And Password',
        );
        log(message.toString());
        return null;
      }

      return AuthLocallySavedDetails.fromMap(json.decode(value));
    } catch (e) {
      if (e is PlatformException && e.code == 'BadPaddingException') {
        await storage.deleteAll();
      }

      rethrow;
    }
  }

  @override
  void clearLoginData() {
    storage.delete(key: _loginDetailsKey);
  }

  @override
  Future<bool> checkIfLoginDataIsSaved() async {
    // final String? value = await storage.read(key: _loginDetailsKey);
    // final String? biometricStatus = await storage.read(key: _bioMetricStatus);
    // final bool canUseThumbPrint = await this.canUseThumbPrint();

    // if (value != null && biometricStatus == 'true' && canUseThumbPrint) {
    //   return true;
    // } else {
    //   return false;
    // }
    final String? value = await storage.read(key: _loginDetailsKey);

    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> toggleBiometric(bool value) async {
    await storage.write(key: _bioMetricStatus, value: value.toString());
    return value;
  }

  @override
  Future<bool> checkBiometricToggleState() async {
    final String? biometricStatus = await storage.read(key: _bioMetricStatus);
    return biometricStatus == 'true' ? true : false;
  }

  @override
  Future<bool> toggleDarkMode(bool value) async {
    await storage.write(key: _darkModeStatus, value: value.toString());
    return value;
  }

  @override
  Future<bool> checkDarkModeToggleState() async {
    final String? darkModeStatus = await storage.read(key: _darkModeStatus);
    return darkModeStatus == 'true' ? true : false;
  }

  @override
  Future<String?> getToken() async {
    final String? token = await storage.read(key: _token);

    return token;
  }

  @override
  Future<String?> getRefreshToken() async {
    final String? token = await storage.read(key: _refreshToken);

    return token;
  }

  @override
  Future<void> clearToken() async {
    await storage.delete(key: _token); // Correct way to clear the token
    await storage.delete(key: _refreshToken); // Correct way to clear the token
  }

  @override
  Future<void> saveToken(String token) async {
    await storage.write(key: _token, value: token);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await storage.write(key: _refreshToken, value: refreshToken);
  }

  @override
  Future<bool> isNotFirstTimeUsingApp() async {
    final String? isNotFirstTime = await storage.read(key: _isNotFirstTimeKey);

    if (isNotFirstTime == "true") return true;

    await storage.write(key: _isNotFirstTimeKey, value: "true");
    return false;
  }

  @override
  Future<bool> toggleAmountVisibility(bool value) async {
    await storage.write(key: _amountVisibility, value: value.toString());
    return value;
  }

  // Add method to check the current visibility state
  @override
  Future<bool> checkAmountVisibilityState() async {
    final String? amountVisibility = await storage.read(key: _amountVisibility);
    return amountVisibility == 'true';
  }

  @override
  Future<String?> getSavedPattern() async {
    // Retrieve the pattern string from secure storage
    return await storage.read(key: _pattern);
  }

  @override
  Future<void> savePattern(String pattern) async {
    await storage.write(key: _pattern, value: pattern);
  }

  @override
  Future<bool?> checkPattern(String pattern) async {
    // Get the saved pattern from storage
    String? savedPattern = await getSavedPattern();

    if (savedPattern == null) {
      return null;
    }

    if (savedPattern == pattern) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> canUseBiometrics() async {
    try {
      // Check if the device has biometric capabilities
      final bool canCheckBiometrics = await localAuth.canCheckBiometrics;

      // Check if the device itself supports biometric authentication
      final bool isDeviceSupported = await localAuth.isDeviceSupported();

      final hasSavedData = await checkIfLoginDataIsSaved();

      // Return true if either condition is satisfied
      return canCheckBiometrics && isDeviceSupported && hasSavedData;
    } catch (e) {
      // Handle any exceptions and return false
      log('Error checking biometrics: $e');
      return false;
    }
  }
}

class AuthLocallySavedDetails {
  final String phone;
  final String pin;
  final String hasdhedPin;

  AuthLocallySavedDetails({
    required this.phone,
    required this.pin,
    required this.hasdhedPin,
  });

  factory AuthLocallySavedDetails.fromMap(Map<String, dynamic> map) {
    return AuthLocallySavedDetails(
      phone: map['phone'],
      pin: map['pin'],
      hasdhedPin: map['hasdhedPin'],
    );
  }
}
