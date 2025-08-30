class RegisterModel {
  final String message;
  final RegisterData data;
  final int statusCode;

  RegisterModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      message: json['message'] ?? '',
      data: RegisterData.fromJson(json['data']),
      statusCode: json['status_code'] ?? 0,
    );
  }
}

class RegisterData {
  final String token;

  RegisterData({required this.token});

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      token: json['token'] ?? '',
    );
  }
}
