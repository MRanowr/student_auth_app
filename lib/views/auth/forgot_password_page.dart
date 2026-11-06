import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/form_validators.dart';
import 'reset_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _authController = AuthController();

  @override
  void dispose() {
    _identifierController.dispose();
    _authController.dispose();
    super.dispose();
  }

  void _onSendCodePressed() async {
    if (_formKey.currentState!.validate()) {
      final identifier = _identifierController.text.trim();
      final success = await _authController.sendPasswordResetCode(identifier);

      if (!mounted) return;

      if (success) {
        // SnackBar أخضر كما مطلوب في التكليف
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إرسال رمز التحقق بنجاح إلى بريدك الأكاديمي'),
            backgroundColor: Colors.green,
          ),
        );

        // التوجيه تلقائياً لشاشة تعيين كلمة المرور الجديدة
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('فشل إرسال الرمز، تأكد من المعرف المدخل'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('استعادة كلمة المرور')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 10),
              // بطاقة توجيهية أعلى الشاشة توضح آلية إرسال رمز التحقق
              Card(
                color: Colors.blue.shade50,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.blue.shade200),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'الرجاء إدخال البريد الإلكتروني أو الرقم الأكاديمي المرتبط بحسابك. سنقوم بإرسال رمز تحقق (OTP) مكون من 6 أرقام لمساعدتك في تعيين كلمة مرور جديدة.',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // حقل البريد أو الرقم الأكاديمي مع التحقق
              TextFormField(
                controller: _identifierController,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني أو الرقم الأكاديمي',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_search),
                ),
                validator: FormValidators.validateIdentifier,
              ),
              const SizedBox(height: 24),

              // زر "إرسال رمز التحقق"
              AnimatedBuilder(
                animation: _authController,
                builder: (context, child) {
                  return ElevatedButton(
                    onPressed: _authController.isLoadingResetCode ? null : _onSendCodePressed,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: _authController.isLoadingResetCode
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Text('إرسال رمز التحقق', style: TextStyle(fontSize: 16)),
                  );
                },
              ),
              const SizedBox(height: 16),

              // زر العودة لتسجيل الدخول
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('العودة لتسجيل الدخول'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}