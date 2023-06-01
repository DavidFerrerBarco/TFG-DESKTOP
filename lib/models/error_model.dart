import 'dart:convert';

import 'package:my_desktop_app/models/models.dart';

class ErrorModel {
  String status;
  List<CustomError> data;

  ErrorModel({
    required this.status,
    required this.data,
  });

  factory ErrorModel.fromJson(String str) =>
      ErrorModel.fromMap(json.decode(str));

  factory ErrorModel.fromMap(Map<String, dynamic> json) => ErrorModel(
        status: json["status"],
        data: List<CustomError>.from(
            json["data"].map((x) => CustomError.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
