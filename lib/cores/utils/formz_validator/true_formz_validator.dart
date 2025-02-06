import 'package:formz/formz.dart';

enum TrueValidatorError { invalid }

class TrueValidator extends FormzInput<bool, TrueValidatorError> {
  const TrueValidator.pure() : super.pure(false);

  const TrueValidator.dirty([super.value = false]) : super.dirty();

  @override
  TrueValidatorError? validator(bool value) {
    return value ? null : TrueValidatorError.invalid;
  }
}
