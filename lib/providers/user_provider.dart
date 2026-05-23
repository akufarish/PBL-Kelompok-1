import 'dart:io';
import 'package:admin_pegawai/models/user.dart';
import 'package:admin_pegawai/services/auth_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final AuthService authService = AuthService();

  int _totalUser = 0;
  int _totalRole = 0;
  int get totalUser => _totalUser;
  int get totalRole => _totalRole;

  bool isLoading = false;
  UserResponse? _data;
  UserResponse? get data => _data;

  List<UserResponse> _listUser = [];
  List<UserResponse> get listUser => _listUser;

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

  Future<void> fetchDashboardData() async {
    isLoading = true;
    notifyListeners();

    try {
      final initialResponse = await Future.wait([
        authService.fetchPaginatedUsers(1, 10),
        authService.fetchTotalRoles(),
      ]);

      final firstPageResult = initialResponse[0] as UserPaginationResponse?;
      final totalRoleResult = initialResponse[1] as int;

      _totalRole = totalRoleResult;

      if (firstPageResult != null) {
        _totalUser = firstPageResult.totalItems;
        List<UserResponse> temporaryList = List.from(firstPageResult.users);

        // Mengambil langsung jumlah total halaman dari keytotalPages milik api
        int totalPages = firstPageResult.totalPages;

        for (int nextPage = 2; nextPage <= totalPages; nextPage++) {
          final subsequentResult = await authService.fetchPaginatedUsers(
            nextPage,
            10,
          );
          if (subsequentResult != null) {
            temporaryList.addAll(subsequentResult.users);
          }
        }

        _listUser = temporaryList;
      }
    } catch (e) {
      debugPrint("Error fetching dashboard data: $e");
    }

    isLoading = false;
    notifyListeners();
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
    notifyListeners();
  }
}
