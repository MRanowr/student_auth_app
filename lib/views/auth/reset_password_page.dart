import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/form_validators.dart';
import 'login_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final _authController = AuthController();

  @override
  void dispose() {
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    _authController.dispose();
    super.dispose();
  }

  void _onResetPasswordPressed() async {
    if (_formKey.currentState!.validate()) {
      final otp = _otpController.text.trim();
      final newPassword = _newPasswordController.text;

      final success = await _authController.resetPassword(otp, newPassword);

      if (!mounted) return;

      if (success) {
        // عرض نافذة تأكيد نجاح التحديث (Dialog) والتوجيه لشاشة الدخول كما مطلوب
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('تم التحديث بنجاح'),
            content: const Text('تم تحديث كلمة المرور الخاصة بك بنجاح. يمكنك الآن تسجيل الدخول باستخدام كلمة المرور الجديدة.'),
            actions: [
              TextButton(
                onPressed: () {
                  // العودة لشاشة تسجيل الدخول ومسح كل الشاشات السابقة
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
                child: const Text('تسجيل الدخول'),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('فشل تحديث كلمة المرور، تحقق من رمز التحقق'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تعيين كلمة المرور الجديدة')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 10),
              // حقل رمز التحقق (OTP) - 6 أرقام رقمية حصراً
              TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  labelText: 'رمز التحقق (6 أرقام)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_clock),
                  counterText: '',
                ),
                validator: FormValidators.validateOtp,
              ),
              const SizedBox(height: 16),

              // حقل كلمة المرور الجديدة (مطابقة سياسة الأمان القوية)
              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور الجديدة (حرف كبير + رقم + 8 خانات)',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                validator: FormValidators.validateStrongPassword,
              ),
              const SizedBox(height: 16),

              // حقل تأكيد كلمة المرور الجديدة
              TextFormField(
                controller: _confirmNewPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'تأكيد كلمة المرور الجديدة',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء تأكيد كلمة المرور الجديدة';
                  }
                  if (value != _newPasswordController.text) {
                    return 'كلمتا المرور غير متطابقتين';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // زر "تحديث كلمة المرور"
              AnimatedBuilder(
                animation: _authController,
                builder: (context, child) {
                  return ElevatedButton(
                    onPressed: _authController.isLoadingUpdatePassword ? null : _onResetPasswordPressed,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: _authController.isLoadingUpdatePassword
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Text('تحديث كلمة المرور', style: TextStyle(fontSize: 16)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}