import 'dart:convert';

import 'package:my_desktop_app/models/models.dart';

class NewsModel {
  String status;
  List<News> data;

  NewsModel({
    required this.status,
    required this.data,
  });

  factory NewsModel.fromJson(String str) => NewsModel.fromMap(json.decode(str));

  factory NewsModel.fromMap(Map<String, dynamic> json) => NewsModel(
        status: json["status"],
        data: List<News>.from(json["data"].map((x) => News.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
