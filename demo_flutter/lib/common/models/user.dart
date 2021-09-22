// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.code,
    this.message,
    this.result,
  });

  int? code;
  String? message;
  Result? result;

  factory User.fromJson(Map<String, dynamic> json) => User(
        code: json["code"],
        message: json["message"],
        result: Result?.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "result": result?.toJson(),
      };
}

class Result {
  Result({
    this.userId,
    this.mobile,
    this.accessToken,
    this.userAvatar,
    this.nickName,
    this.faceAuthFlag,
    this.nameAuthFlag,
    this.clientId,
  });

  int? userId;
  String? mobile;
  String? accessToken;
  dynamic? userAvatar;
  String? nickName;
  int? faceAuthFlag;
  int? nameAuthFlag;
  String? clientId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        userId: json["userId"],
        mobile: json["mobile"],
        accessToken: json["accessToken"],
        userAvatar: json["userAvatar"],
        nickName: json["nickName"],
        faceAuthFlag: json["faceAuthFlag"],
        nameAuthFlag: json["nameAuthFlag"],
        clientId: json["clientId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "mobile": mobile,
        "accessToken": accessToken,
        "userAvatar": userAvatar,
        "nickName": nickName,
        "faceAuthFlag": faceAuthFlag,
        "nameAuthFlag": nameAuthFlag,
        "clientId": clientId,
      };
}
