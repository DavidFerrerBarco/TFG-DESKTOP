import 'dart:convert';

class News {
  String id;
  String title;
  String content;
  String date;
  int v;

  News({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.v,
  });

  factory News.fromJson(String str) => News.fromMap(json.decode(str));

  factory News.fromMap(Map<String, dynamic> json) => News(
        id: json["_id"],
        title: json["title"],
        content: json["content"],
        date: json["date"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "content": content,
        "date": date,
        "__v": v,
      };
}
