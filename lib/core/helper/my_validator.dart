
abstract class AppValidator {
  String? validate(String? value);
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) return 'Email is required';
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
  return null;
}

String? passwordValidator(String? value, {String? confirm}) {
  if (value == null || value.isEmpty) return 'Password is required';
  if (confirm != null && confirm != value) {
    return 'Password Does not Match';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}

String? phoneValidator(String? value) {
  if (value == null || value.isEmpty) return 'Phone number is required';
  final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
  if (!phoneRegex.hasMatch(value)) return 'Enter a valid phone number';
  return null;
}

String? requiredValidator(String? value) {
  if (value == null || value.trim().isEmpty) return 'Field is required';
  return null;
}

class IntegerValidator extends AppValidator {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    if (int.tryParse(value) == null) return 'Enter a valid integer';
    return null;
  }
}
