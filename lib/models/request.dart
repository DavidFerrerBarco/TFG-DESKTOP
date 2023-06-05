import 'dart:convert';

class Request {
  String title;
  String content;
  String employee;
  String id;
  String date;
  int v;

  Request({
    required this.title,
    required this.content,
    required this.employee,
    required this.id,
    required this.date,
    required this.v,
  });

  factory Request.fromJson(String str) => Request.fromMap(json.decode(str));

  factory Request.fromMap(Map<String, dynamic> json) => Request(
        title: json["title"],
        content: json["content"],
        employee: json["employee"],
        id: json["_id"],
        date: json["date"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "employee": employee,
        "_id": id,
        "date": date,
        "__v": v,
      };
}
