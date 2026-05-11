import 'package:admin_pegawai/utils/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

Future<void> decodeJwtToken() async {
  String? token = await TokenManager.getAccessToken();

  if (token != null) {
    bool hasExpired = JwtDecoder.isExpired(token);
    debugPrint("hasExpired: $hasExpired");

    if (!hasExpired) {
      Map<String, dynamic> payload = JwtDecoder.decode(token);

      String? roleName = payload["role_name"] ?? "";
      String? userId = payload["user_id"] ?? "";
      // String? userEmail = payload["user_email"] ?? "";
      // String? detailId = payload["detail_id"] ?? "";
      // String? expiredDate = payload["exp"] ?? "";

      debugPrint("Role: $roleName");
      debugPrint("Id User: $userId");

      Duration expiredDate = JwtDecoder.getRemainingTime(token);
      debugPrint("Expired at: $expiredDate");
    } else {
      debugPrint("Token invalid");
    }
  } else {
    debugPrint("Token not found");
  }
}
