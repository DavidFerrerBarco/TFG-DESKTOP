import 'dart:convert';

import 'package:my_desktop_app/models/models.dart';

class ScheduleModel {
  String status;
  List<Schedule> data;

  ScheduleModel({
    required this.status,
    required this.data,
  });

  factory ScheduleModel.fromJson(String str) =>
      ScheduleModel.fromMap(json.decode(str));

  factory ScheduleModel.fromMap(Map<String, dynamic> json) => ScheduleModel(
        status: json["status"],
        data: List<Schedule>.from(json["data"].map((x) => Schedule.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
