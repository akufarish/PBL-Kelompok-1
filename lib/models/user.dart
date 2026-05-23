class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(email: json["email"], password: json["password"]);
  }

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String roleName;
  final int detailId;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.roleName,
    required this.detailId,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      name: json["name"],
      email: json["email"],
      password: json["password"],
      roleName: json["role_name"],
      detailId: json["detail_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "role_name": roleName,
    "detail_id": detailId,
  };
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

class UserResponse {
  final String id;
  final String name;
  final String email;
  final String roleName;
  final String? detailId;
  final String? imageUrl;

  UserResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.roleName,
    required this.detailId,
    required this.imageUrl,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      roleName: json["role_name"],
      detailId: json["detail_id"],
      imageUrl: json["image_url"],
    );
  }
}

class UserPaginationResponse {
  final int totalItems;
  final int totalPages;
  final List<UserResponse> users;

  UserPaginationResponse({
    required this.totalItems,
    required this.totalPages,
    required this.users,
  });

  factory UserPaginationResponse.fromJson(Map<String, dynamic> json) {
    final rootData = json['data'] ?? {};
    final pagination = rootData['pagination'] ?? {};
    final listItems = rootData['items'] as List? ?? [];

    return UserPaginationResponse(
      totalItems: pagination['total_items'] ?? 0,
      totalPages: pagination['total_pages'] ?? 0,
      users: listItems.map((e) => UserResponse.fromJson(e)).toList(),
    );
  }
}

class RolePaginationResponse {
  final int totalRoles;

  RolePaginationResponse({required this.totalRoles});

  factory RolePaginationResponse.fromJson(Map<String, dynamic> json) {
    final rootData = json['data'] ?? {};
    return RolePaginationResponse(totalRoles: rootData['total_items'] ?? 0);
  }
}

class UserCount {
  final int total;

  UserCount({required this.total});

  factory UserCount.fromJson(Map<String, dynamic> json) {
    return UserCount(total: json["data"] ?? 0);
  }
}
