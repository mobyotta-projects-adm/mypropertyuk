// To parse this JSON data, do
//
//     final getExpensesModel = getExpensesModelFromJson(jsonString);

import 'dart:convert';

GetExpensesModel getExpensesModelFromJson(String str) => GetExpensesModel.fromJson(json.decode(str));

String getExpensesModelToJson(GetExpensesModel data) => json.encode(data.toJson());

class GetExpensesModel {
  GetExpensesModel({
    required this.id,
    required this.userId,
    required this.expenseName,
    required this.cost,
    required this.date,
  });

  String id;
  String userId;
  String expenseName;
  String cost;
  DateTime date;

  factory GetExpensesModel.fromJson(Map<String, dynamic> json) => GetExpensesModel(
    id: json["id"],
    userId: json["user_id"],
    expenseName: json["expense_name"],
    cost: json["cost"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "expense_name": expenseName,
    "cost": cost,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
}
