import 'package:flutter/foundation.dart';
import '../repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthController extends ChangeNotifier {
  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl();

  bool _isLoadingLogin = false;
  bool _isLoadingRegister = false;
  bool _isLoadingResetCode = false;
  bool _isLoadingUpdatePassword = false;

  bool get isLoadingLogin => _isLoadingLogin;
  bool get isLoadingRegister => _isLoadingRegister;
  bool get isLoadingResetCode => _isLoadingResetCode;
  bool get isLoadingUpdatePassword => _isLoadingUpdatePassword;

  // دالة تسجيل الدخول
  Future<bool> login(LoginRequest request) async {
    _isLoadingLogin = true;
    notifyListeners();

    try {
      final success = await _authRepository.login(request.identifier, request.password);
      return success;
    } finally {
      _isLoadingLogin = false;
      notifyListeners();
    }
  }

  // دالة إنشاء حساب جديد
  Future<bool> register(RegisterRequest request) async {
    _isLoadingRegister = true;
    notifyListeners();

    try {
      final success = await _authRepository.register(
        request.fullName,
        request.academicId,
        request.email,
        request.password,
      );
      return success;
    } finally {
      _isLoadingRegister = false;
      notifyListeners();
    }
  }

  // دالة إرسال رمز استعادة كلمة المرور (ForgotPassword)
  Future<bool> sendPasswordResetCode(String identifier) async {
    _isLoadingResetCode = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2)); // محاكاة وقت السيرفر
      // نقبل أي معرف أو بريد موجود أو وهمي لإرسال الرمز مؤقتاً
      return true;
    } finally {
      _isLoadingResetCode = false;
      notifyListeners();
    }
  }

  // دالة تحديث كلمة المرور الجديدة (ResetPassword)
  Future<bool> resetPassword(String otp, String newPassword) async {
    _isLoadingUpdatePassword = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2)); // محاكاة وقت السيرفر
      // إذا تم إدخال أي OTP مكون من أرقام، نعتبر العملية ناجحة
      return otp.isNotEmpty && newPassword.length >= 6;
    } finally {
      _isLoadingUpdatePassword = false;
      notifyListeners();
    }
  }
}