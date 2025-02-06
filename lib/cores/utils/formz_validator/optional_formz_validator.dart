import 'package:formz/formz.dart';

enum OptionalValueValidationError { invalid }

class OptionalValue extends FormzInput<String?, OptionalValueValidationError> {
  const OptionalValue.pure([super.value]) : super.pure();

  const OptionalValue.dirty([super.value]) : super.dirty();

  @override
  OptionalValueValidationError? validator(String? value) {
    // Accept null or non-null values
    return null;
  }
}
