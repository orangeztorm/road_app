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

  String get baseUrl => _baseUrl;

  // String get baseUrlV2 => _baseUrlV2;

  // --------------------------------------
  static final String verifyBvn =
      '$_baseUrl/onboarding/api/v1/sign-up/verify-bvn';
  static final String resendOtp =
      '$_baseUrl/onboarding/api/v1/sign-up/resend-otp';
  static final String verifyOtp =
      '$_baseUrl/onboarding/api/v1/sign-up/verify-otp';
  static final String createAccount =
      '$_baseUrl/onboarding/api/v1/sign-up/create-profile-and-account';
  static final String resetPinVerifyBvn =
      '$_baseUrl/onboarding/api/v1/forgot-pin/resend-otp';
  // static final String resetPinResendOtp =
  //     '$_baseUrl/onboarding/api/v1/sign-up/create-account';
  static final String resetPinVerifyOtp =
      '$_baseUrl/onboarding/api/v1/forgot-pin/verify-otp';
  static final String forgotPasswordResetPin =
      '$_baseUrl/onboarding/api/v1/forgot-pin/reset';

  // forgot password
  static final String forgotPasswordVerifyBvn =
      '$_baseUrl/onboarding/api/v1/forgot-pin/verify-bvn';

  static final String forgotPasswordResendOtp =
      '$_baseUrl/onboarding/api/v1/forgot-pin/resend-otp';

  static final String forgotPasswordVerifyOtp =
      '$_baseUrl/onboarding/api/v1/forgot-pin/verify-otp';

  static final String forgotPasswordResetPassword =
      '$_baseUrl/onboarding/api/v1/forgot-pin/reset';

  // login
  static final String login = '$_baseUrl/user/auth/login';

  static final String getUserLoginState =
      '$_baseUrl/onboarding/api/v1/user-login-state';

  static String accountBalance = '$_baseUrl/onboarding/api/v1/accounts/balance';

  // wallet

  static final String getBanks =
      '$_baseUrl/transaction/api/v1/transactions/get-banks';

  static final String bankAccountInquiry =
      '$_baseUrl/transaction/api/v1/transactions/account-enquiry';

  static final String getCharge =
      '$_baseUrl/transaction/api/v1/transactions/get-service-charge';

  static final String bankTransfer =
      '$_baseUrl/transaction/api/v1/transactions/async-interbank-debit-transfer';

  static final String saveBeneficiary =
      '$_baseUrl/transaction/api/v1/transactions/save-beneficiary';

  static final String getBeneficiaries =
      '$_baseUrl/transaction/api/v1/transactions/get-beneficiaries';

  // bills
  static final String getBillsServices = '$_baseUrl/bills/v1/categories';

  static String getBillsCategory(id) => '$_baseUrl/bills/v1/category/$id';

  static String getinputFields(inputField) =>
      '$_baseUrl/bills/v1/category/input/$inputField';

  static final String biilValidateInputs =
      '$_baseUrl/bills/v1/utility/validate';

  static final String billPay =
      '$_baseUrl/transaction/api/v1/transactions/pay-bill/utility';
  // static final String electricityPay = '$_baseUrl/bills/v1/utility/pay';
  static final String electricityPay =
      '$_baseUrl/transaction/api/v1/transactions/pay-bill/utility';
  // static final String cablePay = '$_baseUrl/bills/v1/cable/purchase';
  static final String cablePay =
      '$_baseUrl/transaction/api/v1/transactions/pay-bill/utility';
  // static final String airtimePay = '$_baseUrl/bills/v1/airtime/purchase';
  static final String airtimePay =
      '$_baseUrl/transaction/api/v1/transactions/pay-bill/airtime';
  // static final String dataPay = '$_baseUrl/bills/v1/data/pay';
  static final String dataPay =
      '$_baseUrl/transaction/api/v1/transactions/pay-bill/data';

  static final String transactionStatus =
      '$_baseUrl/transaction/api/v1/transactions/query-transaction-status';

  static final String transactionHistory =
      '$_baseUrl/transaction/api/v1/transactions/history';

  // Tier
  static final String upgradeTier1 =
      '$_baseUrl/onboarding/api/v1/accounts/upgrade-from-tier1';

  static final String upgradeTier2 =
      '$_baseUrl/onboarding/api/v1/accounts/upgrade-from-tier2';

  // Customer Feedback
  static final String sendFeedbacks = '$_baseUrl/onboarding/api/v1/feedbacks';
  static final String getFeedBackTypes =
      '$_baseUrl/onboarding/api/v1/feedbacks/types';

  static final String refreshToken = '$_baseUrl/user/auth/refresh-token';
  static final String saveToken =
      '$_baseUrl/onboarding/api/v1/profiles/notification-token';
  static final String logout = '$_baseUrl/user/profile/logout';
  static final String changePin =
      '$_baseUrl/onboarding/api/v1/profiles/change-pin';
  static final String getNotifications =
      '$_baseUrl/onboarding/api/v1/profiles/notifications';

  // crypto Wallet
  static final String getCryptoWallets =
      '$_baseUrl/onboarding/api/v1/accounts/quidax/wallets';
  static final String getAssets =
      '$_baseUrl/onboarding/api/v1/accounts/quidax/assets';
  static String getCryptoWallet(crypto) =>
      '$_baseUrl/onboarding/api/v1/accounts/quidax/wallets/$crypto';
  static final String createSubAccount =
      '$_baseUrl/onboarding/api/v1/accounts/quidax/create-sub-account';
  static final String addAssetsToHoldings =
      '$_baseUrl/onboarding/api/v1/accounts/quidax/assets/eth/add-to-holdings';
  static final String sellCrypto =
      '$_baseUrl/transaction/api/v1/transactions/sell-crypto';
  static final String buyCrypto =
      '$_baseUrl/transaction/api/v1/transactions/buy-crypto';
  static final String cryptoHistory =
      '$_baseUrl/transaction/api/v1/transactions/crypto-history';
  static final String geticker =
      '$_baseUrl/transaction/api/v1/transactions/crypto-history';

  // Verify Email
  static final String verifyEmailSendOtp =
      '$_baseUrl/user/profile/verify-email/send-otp';
  static final String verifyEmailOtp =
      '$_baseUrl/user/profile/verify-email/verify-otp';

  // Name Tag
  static final String checkNameTag =
      '$_baseUrl/onboarding/api/v1/profiles/check-beam-tag';

  static final String updateProfile = '$_baseUrl/onboarding/api/v1/profiles';
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