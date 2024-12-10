import 'dart:convert';

class User {
  final String id;
  final String username;
  // final String email;
  final int berat;
  final int tinggi;
  // final String gender;
  final String? foto;

  User({
    required this.id,
    required this.username,
    // required this.email,
    required this.berat,
    required this.tinggi,
    // required this.gender,
    this.foto,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json)
    => User(
      id: json['id'].toString(),
      username: json['username'],
      // email: json['email'],
      berat: json['berat'],
      tinggi: json['tinggi'],
      // gender: json['gender'],
      foto: json['foto'],
    );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      // 'email': email,
      'berat': berat,
      'tinggi': tinggi,
      // 'gender': gender,
      'foto': foto,
    };
  }
}