// To parse this JSON data, do
//
//     final signupResponse = signupResponseFromJson(jsonString);

import 'dart:convert';

SignupResponse signupResponseFromJson(String str) => SignupResponse.fromJson(json.decode(str));

String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());

class SignupResponse {
  SignupResponse({
    required this.user,
    required this.message,
  });

  User user;
  String message;

  factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
    user: User.fromJson(json["user"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "message": message,
  };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.isEmployer,
  });

  int id;
  String username;
  String email;
  bool isEmployer;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    isEmployer: json["is_employer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "is_employer": isEmployer,
  };
}
