import 'dart:convert';

class CustomError {
  String id;
  String name;

  CustomError({
    required this.id,
    required this.name,
  });

  factory CustomError.fromJson(String str) =>
      CustomError.fromMap(json.decode(str));

  factory CustomError.fromMap(Map<String, dynamic> json) => CustomError(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
