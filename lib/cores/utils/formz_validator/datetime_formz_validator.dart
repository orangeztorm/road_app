// create a datetimeValidator
import 'package:formz/formz.dart';

enum DateTimeValidationError { invalid }

class DateTimeValidator extends FormzInput<DateTime?, DateTimeValidationError> {
  const DateTimeValidator.pure([super.value]) : super.pure();

  const DateTimeValidator.dirty([super.value]) : super.dirty();

  @override
  DateTimeValidationError? validator(DateTime? value) {
    if (value != null) {
      return null;
    } else {
      return DateTimeValidationError.invalid;
    }
  }
}
