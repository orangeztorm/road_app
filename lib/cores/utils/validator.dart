String? formFieldValidator(String? value, String title, int length) {
  if (value == '' || value == null) {
    return '$title must not be empty!';
  } else if (value.trim().length <= length) {
    return '$title must be over $length characters long!';
  }

  return null;
}

String? textValidator(String? value) {
  if (value == '' || value == null) {
    return 'text must not be empty!';
  }
  return null;
}

String? pinValidator(String? value) {
  if (value == '' || value == null) {
    return 'Pin must not be empty!';
  } else if (value.trim().length != 4) {
    return 'Pin Must be 4 characters long!';
  }

  return null;
}

String? pinMatchValidator(String? value, String? values2) {
  if (value == '' || value == null) {
    return 'Pin must not be empty!';
  } else if (value.trim().length != 4) {
    return 'Pin Must be 4 characters long!';
  } else if (value != values2) {
    return 'Confrim Pin Must match New Pin!';
  }

  return null;
}

String? passwordValidator(String? value) {
  RegExp regex =
      RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@#$%^&+=!])(?!.*\s).{8,}$');

  if (value == '' || value == null) {
    return 'Password must not be empty!';
  } else if (value.trim().length < 8) {
    return 'Password Must be minimum of 8 characters long!';
  } else if (regex.hasMatch(value) == false) {
    return 'Passwords must contain at least one letter, one number, and one special character';
    // return 'Password Must contain at letters, number and special characters! e.g "?=.*[@#\$%^&+=!"';
  }

  return null;
}

String? passwordMatchValidator(String? value, String password) {
  if (value == '' || value == null) {
    return 'Password must not be empty!';
  } else if (value.trim().length < 8) {
    return 'Password Must be minimum of 8 characters long!';
  } else if (value.trim() != password.trim()) {
    return 'Password Does Not Match!';
  }

  return null;
}

String? emailValidator(String? value) {
  if (value == '' || value == null) {
    return 'Email must not be empty!';
  } else if (value.trim().length <= 3) {
    return 'Email must be over 3 characters long!';
  } else if (!value.trim().contains('@')) {
    return 'Invalid Email Address';
  } else if (!value.trim().contains('.')) {
    return 'Invalid Email Address';
  }

  return null;
}

String? nameValidator(String? value) {
  if (value == '' || value == null) {
    return 'Name must not be empty!';
  } else if (value.trim().length <= 2) {
    return 'Name must be min 3 characters long!';
  }
  return null;
}

String? usernameValidator(String? value) {
  final usernameRegExp = RegExp(r'^[A-Za-z][A-Za-z0-9_]{3,29}$');

  if (value == '' || value == null) {
    return 'Username must not be empty!';
  } else if (value.trim().length <= 4) {
    return 'Username must be min 5 characters long!';
  } else if (usernameRegExp.hasMatch(value) != true) {
    return 'Username must be at least 5 characters, and can only contain letters, numbers, and underscores.';
  }
  return null;
}

String? mobileValidator(String? value) {
  if (value == '' || value == null) {
    return 'Mobile must not be empty!';
  } else if (value.trim().length <= 9) {
    return 'Mobile must be min 10 characters long!';
  }
  return null;
}

String? amountValidator(String? value) {
  if (value == '' || value == null) {
    return 'Amount must not be empty!';
  }
  return null;
}
