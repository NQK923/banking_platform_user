class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập email.';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Email không hợp lệ.';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Phone is optional in our schema
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{9,15}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Số điện thoại không hợp lệ (9-15 chữ số).';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu.';
    }
    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự.';
    }
    return null;
  }

  static String? validatePin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mã PIN.';
    }
    final pinRegex = RegExp(r'^[0-9]{6}$');
    if (!pinRegex.hasMatch(value)) {
      return 'Mã PIN phải gồm đúng 6 chữ số.';
    }
    return null;
  }

  static String? validateIdentifier(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập Email hoặc Số điện thoại.';
    }
    final val = value.trim();
    if (val.contains('@')) {
      return validateEmail(val);
    } else {
      // Must be a valid phone number format
      final phoneRegex = RegExp(r'^\+?[0-9]{9,15}$');
      if (!phoneRegex.hasMatch(val)) {
        return 'Email hoặc Số điện thoại không hợp lệ.';
      }
    }
    return null;
  }
}
