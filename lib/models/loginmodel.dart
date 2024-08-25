// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String email;
  String username;
  String firstName;
  String lastName;
  int id;
  String token;

  User({
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    email: json["email"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    id: json["id"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "id": id,
    "token": token,
  };
}