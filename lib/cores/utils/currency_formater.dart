import 'package:intl/intl.dart';

String currencyFormatter(
  num? amount, {
  String? locale,
  bool showDecimal = true,
}) {
  amount ??= 0.0;
  locale = locale == '\u20A6'
      ? _currencyFromLocale(locale)?.toUpperCase()
      : _currencyFromLocale(locale);
  final NumberFormat formatter = NumberFormat(
    showDecimal
        ? '${locale ?? "\u20A6"}#,##0.00'
        : '${locale ?? "\u20A6"}#,##0',
    'en_US',
  );
  return formatter.format(amount);
}

String? _currencyFromLocale(String? locale) {
  locale = locale?.toLowerCase();

  if (locale == "ngn") {
    return "\u20A6";
  } else if (locale == "usd") {
    return "\$";
  } else if (locale == "gbp") {
    return "£";
  } else if (locale == "eur") {
    return "€";
  } else if (locale == "gha" || locale == "ghs") {
    return "₵";
  } else if (locale == "ken") {
    return "Ksh";
  }

  return locale;
}

String formatPhoneNumber(String phoneNumber) {
  phoneNumber = phoneNumber.trim();

  if (phoneNumber.startsWith('+')) {
    phoneNumber = phoneNumber.substring(1);
  }

  if (phoneNumber.length == 11) {
    return '+${phoneNumber.substring(0, 4)} ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
  } else {
    return phoneNumber; // Return the original input if it doesn't match the expected format
  }
}
