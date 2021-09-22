// To parse this JSON data, do
//
//     final logoutList = logoutListFromJson(jsonString);

import 'dart:convert';

LogoutList logoutListFromJson(String str) =>
    LogoutList.fromJson(json.decode(str));

String logoutListToJson(LogoutList data) => json.encode(data.toJson());

class LogoutList {
  LogoutList({
    this.code,
    this.message,
    this.result,
  });

  int? code;
  String? message;
  Result? result;

  factory LogoutList.fromJson(Map<String, dynamic> json) => LogoutList(
        code: json["code"],
        message: json["message"],
        result: json["result"] != null ? Result.fromJson(json["result"]) : null,
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
    this.canCancel,
    this.forbidCancelReasons,
    this.sec,
  });

  String? userId;
  int? canCancel;
  List<ForbidCancelReason>? forbidCancelReasons;
  String? sec;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        userId: json["userId"],
        canCancel: json["canCancel"],
        forbidCancelReasons: List<ForbidCancelReason>.from(
            json["forbidCancelReasons"]
                .map((x) => ForbidCancelReason.fromJson(x))),
        sec: json["sec"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "canCancel": canCancel,
        "forbidCancelReasons": List<dynamic>.from(
            (forbidCancelReasons ?? []).map((x) => x.toJson())),
        "sec": sec,
      };
}

class ForbidCancelReason {
  ForbidCancelReason({
    this.checkResult,
    this.reasonCode,
    this.reasonDesc,
    this.opNameDesc,
    this.handleRoute,
  });

  bool? checkResult;
  String? reasonCode;
  String? reasonDesc;
  String? opNameDesc;
  HandleRoute? handleRoute;

  factory ForbidCancelReason.fromJson(Map<String, dynamic> json) =>
      ForbidCancelReason(
        checkResult: json["checkResult"],
        reasonCode: json["reasonCode"],
        reasonDesc: json["reasonDesc"],
        opNameDesc: json["opNameDesc"] == null ? null : json["opNameDesc"],
        handleRoute: json["handleRoute"] == null
            ? null
            : HandleRoute.fromJson(json["handleRoute"]),
      );

  Map<String, dynamic> toJson() => {
        "checkResult": checkResult,
        "reasonCode": reasonCode,
        "reasonDesc": reasonDesc,
        "opNameDesc": opNameDesc == null ? null : opNameDesc,
        "handleRoute": handleRoute == null ? null : handleRoute?.toJson(),
      };
}

class HandleRoute {
  HandleRoute({
    this.androidGoPage,
    this.iosGoPage,
    this.appType,
    this.appStartUrl,
  });

  String? androidGoPage;
  String? iosGoPage;
  int? appType;
  String? appStartUrl;

  factory HandleRoute.fromJson(Map<String, dynamic> json) => HandleRoute(
        androidGoPage: json["androidGoPage"],
        iosGoPage: json["iosGoPage"],
        appType: json["appType"],
        appStartUrl: json["appStartUrl"],
      );

  Map<String, dynamic> toJson() => {
        "androidGoPage": androidGoPage,
        "iosGoPage": iosGoPage,
        "appType": appType,
        "appStartUrl": appStartUrl,
      };
}
