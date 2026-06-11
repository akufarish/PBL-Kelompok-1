class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(email: json["email"], password: json["password"]);
  }

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}


class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final String roleName;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.roleName,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"],
      roleName: json["role_name"],
    );
  }
}

class ResetPassword {
  final String email;
  final String newPassword;
  final String confirmPassword;

  ResetPassword({
    required this.email,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "new_password": newPassword,
    "confirm_password": confirmPassword,
  };
}
