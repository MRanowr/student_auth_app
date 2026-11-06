class FormValidators {
  static String? validateIdentifier(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    if (value.trim().length < 5) {
      return 'يجب ألا يقل عن 5 محارف';
    }
    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الاسم الكامل مطلوب';
    }
    if (value.trim().length < 3) {
      return 'الاسم يجب أن يكون 3 محارف على الأقل';
    }
    return null;
  }

  static String? validateAcademicId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الرقم الأكاديمي مطلوب';
    }
    final numericRegex = RegExp(r'^\d{9,10}$');
    if (!numericRegex.hasMatch(value.trim())) {
      return 'يجب أن يتكون من أرقام حصراً (بين 9 إلى 10 خانات)';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'صيغة البريد الإلكتروني غير صحيحة';
    }
    return null;
  }

  static String? validateStrongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < 8) {
      return 'يجب ألا تقل كلمة المرور عن 8 محارف';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'يجب أن تحتوي على حرف كبير واحد على الأقل';
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'يجب أن تحتوي على رقم واحد على الأقل';
    }
    return null;
  }

  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < 6) {
      return 'كلمة المرور قصيرة جداً (أقل شيء 6 محارف)';
    }
    return null;
  }

  static String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رمز التحقق مطلوب';
    }
    if (!RegExp(r'^\d{6}$').hasMatch(value.trim())) {
      return 'يجب أن يتكون الرمز من 6 أرقام حصراً';
    }
    return null;
  }
}