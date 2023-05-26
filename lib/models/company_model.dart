import 'dart:convert';
import 'models.dart';

class CompanyModel {
  String status;
  List<Company> data;

  CompanyModel({
      required this.status,
      required this.data,
  });

  factory CompanyModel.fromJson(String str) => 
    CompanyModel.fromMap(json.decode(str));

  factory CompanyModel.fromMap(Map<String, dynamic> json) => CompanyModel(
      status: json["status"],
      data: List<Company>.from(
        json["data"].map((x) => Company.fromMap(x))),
  );

  Map<String, dynamic> toJson() => {
      "status": status,
      "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}