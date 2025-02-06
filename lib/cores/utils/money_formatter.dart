library currency_text_input_formatter;

import 'dart:math';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyTextInputFormatter extends TextInputFormatter {
  final String? locale;
  final String? name;
  final String? symbol;
  final int? decimalDigits;
  final String? customPattern;
  final bool turnOffGrouping;
  final bool enableNegative;

  CurrencyTextInputFormatter({
    this.locale,
    this.name,
    this.symbol,
    this.decimalDigits = 0,
    this.customPattern,
    this.turnOffGrouping = false,
    this.enableNegative = true,
  });

  num _newNum = 0;
  String _newString = '';
  bool _isNegative = false;

  void _formatter(String newText) {
    final NumberFormat format = NumberFormat.currency(
      locale: locale,
      name: name,
      symbol: symbol,
      decimalDigits: decimalDigits,
      customPattern: customPattern,
    );
    if (turnOffGrouping) format.turnOffGrouping();
    _newNum = num.tryParse(newText) ?? 0;

    if (format.decimalDigits! > 0) {
      _newNum /= pow(10, format.decimalDigits!);
    }

    _newString = (_isNegative ? '-' : '') + format.format(_newNum).trim();
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // final bool isInsertedCharacter =
    //     oldValue.text.length + 1 == newValue.text.length &&
    //         newValue.text.startsWith(oldValue.text);
    final bool isRemovedCharacter =
        oldValue.text.length - 1 == newValue.text.length &&
            oldValue.text.startsWith(newValue.text);
    // Apparently, Flutter has a bug where the framework calls
    // formatEditUpdate twice, or even four times, after a backspace press (see
    // https://github.com/gtgalone/currency_text_input_formatter/issues/11).
    // However, only the first of these calls has inputs which are consistent
    // with a character insertion/removal at the end (which is the most common
    // use case of editing the TextField - the others being insertion/removal
    // in the middle, or pasting text onto the TextField). This condition
    // fixes a problem where a character wasn't properly erased after a
    // backspace press, when this Flutter bug was present. This comes at the
    // cost of losing insertion/removal in the middle and pasting text.
    // if (!isInsertedCharacter && !isRemovedCharacter) {
    //   return oldValue;
    // }

    if (enableNegative) {
      _isNegative = newValue.text.startsWith('-');
    } else {
      _isNegative = false;
    }

    String newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');

    // If the user wants to remove a digit, but the last character of the
    // formatted text is not a digit (for example, "1,00 €"), we need to remove
    // the digit manually.
    if (isRemovedCharacter && !_lastCharacterIsDigit(oldValue.text)) {
      final int length = newText.length - 1;
      newText = newText.substring(0, length > 0 ? length : 0);
    }

    _formatter(newText);

    if (newText.trim() == '' || newText == '00' || newText == '000') {
      return TextEditingValue(
        text: _isNegative ? '-' : '',
        selection: TextSelection.collapsed(offset: _isNegative ? 1 : 0),
      );
    }

    return TextEditingValue(
      text: _newString,
      selection: TextSelection.collapsed(offset: _newString.length),
    );
  }

  static bool _lastCharacterIsDigit(String text) {
    final String lastChar = text.substring(text.length - 1);
    return RegExp('[0-9]').hasMatch(lastChar);
  }

  String getFormattedValue() {
    return _newString;
  }

  num getUnformattedValue() {
    return _isNegative ? (_newNum * -1) : _newNum;
  }

  String format(String value) {
    if (enableNegative) {
      _isNegative = value.startsWith('-');
    } else {
      _isNegative = false;
    }

    final String newText = value.replaceAll(RegExp('[^0-9]'), '');
    _formatter(newText);
    return _newString;
  }
}
