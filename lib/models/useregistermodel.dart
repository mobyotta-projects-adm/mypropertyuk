// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userPassword,
  });

  String userName;
  String userEmail;
  String userPhone;
  String userPassword;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userName: json["user_name"],
    userEmail: json["user_email"],
    userPhone: json["user_phone"],
    userPassword: json["user_password"],
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "user_email": userEmail,
    "user_phone": userPhone,
    "user_password": userPassword,
  };


  
}
