class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T? Function(Map<String, dynamic>) fromJsonT,
  ) {
    return ApiResponse(
      success: json["success"],
      message: json["message"],
      data: json["data"] != null ? fromJsonT(json["data"]) : null,
    );
  }

  static ApiResponse<List<T>> fromJsonList<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final dynamic rawData = json["data"];

    if (rawData == null) {
      return ApiResponse<List<T>>(
        success: json["success"],
        message: json["message"],
        data: null,
      );
    }
    final List<dynamic> jsonList = json["data"];
    return ApiResponse<List<T>>(
      success: json["success"],
      message: json["message"],
      data: jsonList.map((item) => fromJsonT(item)).toList(),
    );
  }
}
