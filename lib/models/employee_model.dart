import 'dart:convert';

import 'package:my_desktop_app/models/models.dart';

class EmployeeModel {
  String status;
  List<Employee> data;

  EmployeeModel({
    required this.status,
    required this.data,
  });

  factory EmployeeModel.fromJson(String str) =>
      EmployeeModel.fromMap(json.decode(str));

  factory EmployeeModel.fromMap(Map<String, dynamic> json) => EmployeeModel(
        status: json["status"],
        data: List<Employee>.from(json["data"].map((x) => Employee.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
