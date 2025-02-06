import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([super.value = '']) : super.pure();

  const Password.dirty([super.value = '']) : super.dirty();

  static final _passwordRegex =
      RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@#$%^&+=!])(?!.*\s).{8,}$');

  @override
  PasswordValidationError? validator(String value) {
    if (_passwordRegex.hasMatch(value)) {
      return null;
    } else {
      return PasswordValidationError.invalid;
    }
  }
}
