import 'dart:convert';

class Task {
  String id;
  String title;
  String content;
  String day;
  String employee;
  String status;
  String date;
  int v;

  Task({
    required this.id,
    required this.title,
    required this.content,
    required this.day,
    required this.employee,
    required this.status,
    required this.date,
    required this.v,
  });

  factory Task.fromJson(String str) => Task.fromMap(json.decode(str));

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json["_id"],
        title: json["title"],
        content: json["content"],
        day: json["day"],
        employee: json["employee"],
        status: json["status"],
        date: json["date"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "content": content,
        "day": day,
        "employee": employee,
        "status": status,
        "date": date,
        "__v": v,
      };
}
