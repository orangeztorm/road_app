import 'package:formz/formz.dart';

enum UsernameValidationError { invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure([super.value = '']) : super.pure();

  const Username.dirty([super.value = '']) : super.dirty();

  static final _usernameRegExp = RegExp(r'^[a-z][a-z0-9_]{0,14}$');

  @override
  UsernameValidationError? validator(String value) {
    if (value.isNotEmpty && _usernameRegExp.hasMatch(value)) {
      return null;
    } else {
      return UsernameValidationError.invalid;
    }
  }
}
