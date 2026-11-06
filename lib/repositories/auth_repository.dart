class AuthRepositoryImpl {
  // قائمة ديناميكية لحفظ الحسابات بدون أي أقواس حادة تسبب مشكلة
  static final List _registeredUsers = [];

  // دالة تسجيل الدخول
  Future<bool> login(String identifier, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // محاكاة وقت السيرفر

    // حساب افتراضي أساسي للتجربة المباشرة
    if (identifier == "202410123" && password == "Password123") {
      return true;
    }

    // البحث داخل الحسابات المسجلة
    for (var user in _registeredUsers) {
      if ((user['identifier'] == identifier || user['email'] == identifier) &&
          user['password'] == password) {
        return true;
      }
    }

    return false;
  }

  // دالة إنشاء حساب جديد وحفظه
  Future<bool> register(String fullName, String academicId, String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    // التأكد أن الرقم الأكاديمي أو البريد غير مسجل مسبقاً
    for (var user in _registeredUsers) {
      if (user['academicId'] == academicId || user['email'] == email) {
        return false; // الحساب موجود مسبقاً
      }
    }

    // حفظ البيانات الجديدة
    _registeredUsers.add({
      'fullName': fullName,
      'academicId': academicId,
      'email': email,
      'identifier': academicId,
      'password': password,
    });

    return true; // تم التسجيل والحفظ بنجاح
  }
}