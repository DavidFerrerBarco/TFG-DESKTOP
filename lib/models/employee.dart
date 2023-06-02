import 'dart:convert';

class Employee {
  String id;
  String name;
  String dni;
  String password;
  String company;
  int contract;
  bool admin;
  String email;
  int v;
  String? token;

  Employee({
    required this.id,
    required this.name,
    required this.dni,
    required this.password,
    required this.company,
    required this.contract,
    required this.admin,
    required this.email,
    required this.v,
    this.token,
  });

  factory Employee.fromJson(String str) => Employee.fromMap(json.decode(str));

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
        id: json["_id"],
        name: json["name"],
        dni: json["DNI"],
        password: json["password"],
        company: json["company"],
        contract: json["contract"],
        admin: json["admin"],
        email: json["email"],
        v: json["__v"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "DNI": dni,
        "password": password,
        "company": company,
        "contract": contract,
        "admin": admin,
        "email": email,
        "__v": v,
        "token": token,
      };
}
