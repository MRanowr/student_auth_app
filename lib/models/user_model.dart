// نموذج بيانات المستخدم (UserModel)
class UserModel {
  final String fullName;
  final String academicId;
  final String email;

  UserModel({
    required this.fullName,
    required this.academicId,
    required this.email,
  });
}

// نموذج طلب تسجيل الدخول (LoginRequest)
class LoginRequest {
  final String identifier; // البريد أو المعرف الأكاديمي
  final String password;
  final bool rememberMe;

  LoginRequest({
    required this.identifier,
    required this.password,
    this.rememberMe = false,
  });
}

// نموذج طلب إنشاء حساب جديد (RegisterRequest)
class RegisterRequest {
  final String fullName;
  final String academicId;
  final String email;
  final String password;
  final bool agreedToTerms;

  RegisterRequest({
    required this.fullName,
    required this.academicId,
    required this.email,
    required this.password,
    required this.agreedToTerms,
  });
}