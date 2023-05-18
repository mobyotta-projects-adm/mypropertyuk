// To parse this JSON data, do
//
//     final getExpensesErrorModel = getExpensesErrorModelFromJson(jsonString);

import 'dart:convert';

GetExpensesErrorModel getExpensesErrorModelFromJson(String str) => GetExpensesErrorModel.fromJson(json.decode(str));

String getExpensesErrorModelToJson(GetExpensesErrorModel data) => json.encode(data.toJson());

class GetExpensesErrorModel {
  GetExpensesErrorModel({
    required this.code,
    required this.response,
    required this.message,
  });

  String code;
  String response;
  String message;

  factory GetExpensesErrorModel.fromJson(Map<String, dynamic> json) => GetExpensesErrorModel(
    code: json["code"],
    response: json["response"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "response": response,
    "message": message,
  };
}
