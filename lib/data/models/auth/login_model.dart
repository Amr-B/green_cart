class LoginModel {
  final String message;
  final Data data;
  final int statusCode;

  LoginModel({
    required this.message,
    required this.data,
    required this.statusCode,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      message: json['message'] as String,
      data: Data.fromJson(json['data']),
      statusCode: json['status_code'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
      'status_code': statusCode,
    };
  }
}

class Data {
  final String token;

  Data({required this.token});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }
}
