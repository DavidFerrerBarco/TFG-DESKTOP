import 'dart:convert';

import 'package:my_desktop_app/models/models.dart';

class AnnouncementModel {
  String status;
  List<Announcement> data;

  AnnouncementModel({
    required this.status,
    required this.data,
  });

  factory AnnouncementModel.fromJson(String str) =>
      AnnouncementModel.fromMap(json.decode(str));

  factory AnnouncementModel.fromMap(Map<String, dynamic> json) =>
      AnnouncementModel(
        status: json["status"],
        data: List<Announcement>.from(
            json["data"].map((x) => Announcement.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
