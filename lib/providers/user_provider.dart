import 'dart:io';
import 'package:admin_pegawai/models/user.dart';
import 'package:admin_pegawai/services/auth_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final AuthService authService = AuthService();

  int _totalUser = 0;
  int get totalUser => _totalUser;

  bool isLoading = false;
  UserResponse? _data;
  UserResponse? get data => _data;

  File? _profileImage;
  File? get profileImage => _profileImage;

  Future<bool> login(LoginRequest payload) async {
    isLoading = true;
    notifyListeners();
    try {
      bool isSuccess = await authService.login(payload);
      isLoading = false;
      notifyListeners();
      return isSuccess;
    } catch (e) {
      debugPrint("$e");
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(RegisterRequest payload) async {
    isLoading = true;
    notifyListeners();
    try {
      bool isSuccess = await authService.register(payload);
      isLoading = false;
      notifyListeners();
      return isSuccess;
    } catch (e) {
      debugPrint("$e");
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> logout() async {
    isLoading = true;
    notifyListeners();
    try {
      bool isSuccess = await authService.logout();
      _data = null;
      _profileImage = null;
      isLoading = false;
      notifyListeners();
      return isSuccess;
    } catch (e) {
      debugPrint("$e");
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> fetchUserCount() async {
    final count = await authService.countUser();
    if (count != null) {
      _totalUser = count;
      notifyListeners(); // Memberitahu UI untuk update angka
    }
  }

  Future<void> profile() async {
    isLoading = true;
    notifyListeners();
    try {
      _data = await authService.profile();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint("$e");
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> resetUser(ResetPassword payload) async {
    isLoading = true;
    notifyListeners();
    try {
      bool isSuccess = await authService.resetPassword(payload);
      isLoading = false;
      notifyListeners();
      return isSuccess;
    } catch (e) {
      debugPrint("$e");
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> setProfile(File image) async {
    _profileImage = image;
    notifyListeners(); // UI akan otomatis update foto setelah dipilih

    // Opsional: Jika ingin langsung upload ke server
    /*
    try {
      await authService.uploadProfileImage(image);
      debugPrint("Upload berhasil");
    } catch (e) {
      debugPrint("Gagal upload: $e");
    }
    */
  }
}
