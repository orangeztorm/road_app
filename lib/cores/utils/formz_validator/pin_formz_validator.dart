import 'package:formz/formz.dart';

enum RequiredPinValidationError { invalid }

class RequiredPin extends FormzInput<String, RequiredPinValidationError> {
  const RequiredPin.pure([super.value = '']) : super.pure();

  const RequiredPin.dirty([super.value = '']) : super.dirty();

  @override
  RequiredPinValidationError? validator(String value) {
    if (value.isNotEmpty && value.length == 4) {
      return null;
    } else {
      return RequiredPinValidationError.invalid;
    }
  }
}
