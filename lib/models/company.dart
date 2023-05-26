import 'dart:convert';

class Company {
  String id;
  String name;
  String address;
  List<int> contractTypes;
  int v;

  Company({
      required this.id,
      required this.name,
      required this.address,
      required this.contractTypes,
      required this.v,
  });

  factory Company.fromJson(String str) => 
    Company.fromMap(json.decode(str));

  factory Company.fromMap(Map<String, dynamic> json) => Company(
      id: json["_id"],
      name: json["name"],
      address: json["address"],
      contractTypes: List<int>.from(json["contractTypes"].map((x) => x)),
      v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
      "_id": id,
      "name": name,
      "address": address,
      "contractTypes": List<dynamic>.from(contractTypes.map((x) => x)),
      "__v": v,
  };
}
