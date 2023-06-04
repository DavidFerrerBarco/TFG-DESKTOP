import 'dart:convert';

class Schedule {
  String id;
  String employee;
  String day;
  List<String> hours;
  int hoursCount;
  int v;

  Schedule({
    required this.id,
    required this.employee,
    required this.day,
    required this.hours,
    required this.hoursCount,
    required this.v,
  });

  factory Schedule.fromJson(String str) => Schedule.fromMap(json.decode(str));

  factory Schedule.fromMap(Map<String, dynamic> json) => Schedule(
        id: json["_id"],
        employee: json["employee"],
        day: json["day"],
        hours: List<String>.from(json["hours"].map((x) => x)),
        hoursCount: json["hoursCount"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "employee": employee,
        "day": day,
        "hours": List<dynamic>.from(hours.map((x) => x)),
        "hoursCount": hoursCount,
        "__v": v,
      };
}
