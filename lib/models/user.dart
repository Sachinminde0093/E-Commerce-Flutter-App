// To parse this JSON data, do
//
//     final posts = postsFromJson(jsonString);

import 'dart:convert';

User postsFromJson(String str) => User.fromJson(json.decode(str));

String postsToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.id,
    required this.token,
  });

  String name;
  String email;
  String password;
  String address;
  String type;
  String id;
  String token;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
        address: json["address"] ?? '',
        type: json["type"] ?? '',
        id: json["_id"] ?? '',
        token: json["token"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "address": address,
        "type": type,
        "_id": id,
        "token": token,
      };
}
