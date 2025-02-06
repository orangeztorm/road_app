import 'package:formz/formz.dart';

enum PhoneValidationError { invalid }

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure([super.value = '']) : super.pure();

  const Phone.dirty([super.value = '']) : super.dirty();

  // static final _phoneRegExp = RegExp(
  //   r'^(?=.{5,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$',
  // );

  @override
  PhoneValidationError? validator(String value) {
    if (value.isNotEmpty) {
      return null;
    } else {
      return PhoneValidationError.invalid;
    }
  }
}
