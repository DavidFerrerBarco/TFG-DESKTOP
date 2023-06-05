import 'dart:convert';

import 'package:my_desktop_app/models/models.dart';

class RequestModel {
  String status;
  List<Request> data;

  RequestModel({
    required this.status,
    required this.data,
  });

  factory RequestModel.fromJson(String str) =>
      RequestModel.fromMap(json.decode(str));

  factory RequestModel.fromMap(Map<String, dynamic> json) => RequestModel(
        status: json["status"],
        data: List<Request>.from(json["data"].map((x) => Request.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
