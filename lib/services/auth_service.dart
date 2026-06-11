import 'package:admin_pegawai/models/api_response.dart';
import 'package:admin_pegawai/models/auth_models.dart';
import 'package:admin_pegawai/utils/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'api_client.dart';

class AuthService {
  final Dio _dio = ApiClient().dio;

  Future<String?> login(LoginRequest payload) async {
    try {
      final response = await _dio.post(
        "/api/auth/login",
        data: payload.toJson(),
      );

      debugPrint("Hit api: ${response.data}");

      if (response.statusCode == 200) {
        final result = ApiResponse<LoginResponse>.fromJson(
          response.data,
          (item) => LoginResponse.fromJson(item),
        );

        await TokenManager.setToken(
          result.data!.accessToken,
          result.data!.refreshToken,
        );

        return result.data!.roleName;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> logout() async {
    try {
      final response = await _dio.post("/api/auth/logout");
      debugPrint("Hit api: ${response.data}");

      if (response.statusCode == 200) {
        await TokenManager.clearToken();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> resetPassword(ResetPassword payload) async {
    try {
      final response = await _dio.post(
        "/api/auth/reset-password",
        data: payload.toJson(),
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error change: $e");
      return false;
    }
  }
}
