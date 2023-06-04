import 'dart:convert';

import 'package:my_desktop_app/models/models.dart';

class TaskModel {
  String status;
  List<Task> data;

  TaskModel({
    required this.status,
    required this.data,
  });

  factory TaskModel.fromJson(String str) => TaskModel.fromMap(json.decode(str));

  factory TaskModel.fromMap(Map<String, dynamic> json) => TaskModel(
        status: json["status"],
        data: List<Task>.from(json["data"].map((x) => Task.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
