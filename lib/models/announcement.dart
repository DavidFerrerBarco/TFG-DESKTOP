import 'dart:convert';

class Announcement {
  String id;
  String title;
  String content;
  String company;
  String date;
  int v;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.company,
    required this.date,
    required this.v,
  });

  factory Announcement.fromJson(String str) =>
      Announcement.fromMap(json.decode(str));

  factory Announcement.fromMap(Map<String, dynamic> json) => Announcement(
        id: json["_id"],
        title: json["title"],
        content: json["content"],
        company: json["company"],
        date: json["date"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "content": content,
        "company": company,
        "date": date,
        "__v": v,
      };
}
