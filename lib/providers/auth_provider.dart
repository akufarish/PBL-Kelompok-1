import 'package:admin_pegawai/models/auth_models.dart';
import 'package:admin_pegawai/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _role;

  bool get isLoading => _isLoading;
  String? get role => _role;

  bool get isSuperAdmin {
    if (_role == null) return false;
    String cleanRole = _role!
        .toLowerCase()
        .replaceAll(' ', '')
        .replaceAll('_', '')
        .replaceAll('-', '');
    return cleanRole == 'superadmin';
  }

  Future<bool> login(LoginRequest payload) async {
    _isLoading = true;
    notifyListeners();
    try {
      String? roleName = await _authService.login(payload);
      _isLoading = false;
      if (roleName != null) {
        _role = roleName;
        notifyListeners();
        return true;
      }
      notifyListeners();
      return false;
    } catch (e) {
      debugPrint("Login Error: $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> logout() async {
    _isLoading = true;
    notifyListeners();
    try {
      bool isSuccess = await _authService.logout();
      if (isSuccess) {
        _role = null;
      }
      _isLoading = false;
      notifyListeners();
      return isSuccess;
    } catch (e) {
      debugPrint("Logout Error: $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> resetUser(ResetPassword payload) async {
    _isLoading = true;
    notifyListeners();
    try {
      bool isSuccess = await _authService.resetPassword(payload);
      _isLoading = false;
      notifyListeners();
      return isSuccess;
    } catch (e) {
      debugPrint("Reset Password Error: $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
