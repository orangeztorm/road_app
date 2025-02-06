import 'package:formz/formz.dart';

enum RequiredValidationError { invalid }

class Required extends FormzInput<String?, RequiredValidationError> {
  const Required.pure([String super.value = '']) : super.pure();

  const Required.dirty([String super.value = '']) : super.dirty();

  @override
  RequiredValidationError? validator(String? value) {
    if (value?.isNotEmpty ?? true) {
      return null;
    } else {
      return RequiredValidationError.invalid;
    }
  }
}

class RequiredDouble extends FormzInput<double, RequiredValidationError> {
  const RequiredDouble.pure([super.value = 0]) : super.pure();

  const RequiredDouble.dirty([super.value = 0]) : super.dirty();

  @override
  RequiredValidationError? validator(double value) {
    if (value != 0) {
      return null;
    } else {
      return RequiredValidationError.invalid;
    }
  }
}

class RequiredInt extends FormzInput<int, RequiredValidationError> {
  const RequiredInt.pure([super.value = 0]) : super.pure();

  const RequiredInt.dirty([super.value = 0]) : super.dirty();

  @override
  RequiredValidationError? validator(int value) {
    if (value != 0) {
      return null;
    } else {
      return RequiredValidationError.invalid;
    }
  }
}

class RequiredBool extends FormzInput<bool, RequiredValidationError> {
  const RequiredBool.pure([super.value = false]) : super.pure();

  const RequiredBool.dirty([super.value = false]) : super.dirty();

  @override
  RequiredValidationError? validator(bool value) {
    if (value == true) {
      return null;
    } else {
      return RequiredValidationError.invalid;
    }
  }
}

class RequiredLength extends FormzInput<String, RequiredValidationError> {
  final int minLength;

  const RequiredLength.pure({String value = '', required this.minLength})
      : super.pure(value);

  const RequiredLength.dirty({String value = '', required this.minLength})
      : super.dirty(value);

  @override
  RequiredValidationError? validator(String value) {
    if (value.length >= minLength) {
      return null;
    } else {
      return RequiredValidationError.invalid;
    }
  }
}

class RequiredNum extends FormzInput<num, RequiredValidationError> {
  const RequiredNum.pure([double super.value = 0]) : super.pure();

  const RequiredNum.dirty([double super.value = 0]) : super.dirty();

  @override
  RequiredValidationError? validator(num value) {
    if (value != 0) {
      return null;
    } else {
      return RequiredValidationError.invalid;
    }
  }
}
