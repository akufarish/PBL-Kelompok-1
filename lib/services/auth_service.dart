import 'dart:convert';

import 'package:admin_pegawai/models/api_response.dart';
import 'package:admin_pegawai/models/user.dart';
import 'package:admin_pegawai/utils/log.dart';
import 'package:admin_pegawai/utils/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final String kelompok1Url = dotenv.get("KELOMPOK_1_BASE_URL");

  Future<bool> login(LoginRequest payload) async {
    try {
      final response = await http.post(
        Uri.parse("$kelompok1Url/api/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload.toJson()),
      );
      final jsonResponse = jsonDecode(response.body);
      debugPrint("Hit api: $jsonResponse");

      if (response.statusCode == 200) {
        final result = ApiResponse<LoginResponse>.fromJson(
          jsonResponse,
          (item) => LoginResponse.fromJson(item),
        );

        await TokenManager.setToken(
          result.data!.accessToken,
          result.data!.refreshToken,
        );

        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> register(RegisterRequest payload) async {
    try {
      String? token = await TokenManager.getAccessToken();

      final response = await http.post(
        Uri.parse("$kelompok1Url/api/user"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(payload.toJson()),
      );
      final jsonResponse = jsonDecode(response.body);
      debugPrint("Hit api: $jsonResponse");
      log("login", jsonResponse);

      if (response.statusCode == 200) {
        debugPrint("Data berhasil ditambahkan");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      String? token = await TokenManager.getAccessToken();
      final response = await http.post(
        Uri.parse("$kelompok1Url/api/auth/logout"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      final jsonResponse = jsonDecode(response.body);
      debugPrint("Hit api: $jsonResponse");

      if (response.statusCode == 200) {
        await TokenManager.clearToken();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<UserResponse?> profile() async {
    try {
      String? token = await TokenManager.getAccessToken();
      final response = await http.get(
        Uri.parse("$kelompok1Url/api/me"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      final jsonResponse = jsonDecode(response.body);
      debugPrint("Hit api: $jsonResponse");

      if (response.statusCode == 200) {
        final result = ApiResponse<UserResponse>.fromJson(
          jsonResponse,
          (item) => UserResponse.fromJson(item),
        );
        debugPrint(result.data.toString());
        return result.data;
      } else {
        debugPrint("samting wong");
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> resetPassword(ResetPassword payload) async {
    try {
      String? token = await TokenManager.getAccessToken();
      final response = await http.post(
        Uri.parse("$kelompok1Url/api/auth/reset-password"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(payload.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Error change: $e");
      return false;
    }
  }

  Future<int?> countUser() async {
    try {
      String? token = await TokenManager.getAccessToken();
      final response = await http.get(
        Uri.parse("$kelompok1Url/api/user/count"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Ambil nilai integer dari field 'data'
        return jsonResponse['data'] as int;
      }
      return null;
    } catch (e) {
      debugPrint("Error countUser: $e");
      return null;
    }
  }
}
