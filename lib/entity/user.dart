class User {
  final String id;
  final String username;
  final String email;
  final int berat;
  final int tinggi;
  final String gender;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.berat,
    required this.tinggi,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      username: json['username'],
      email: json['email'],
      berat: json['berat'],
      tinggi: json['tinggi'],
      gender: json['gender'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'username': username,
  //     'email': email,
  //     'berat': berat,
  //     'tinggi': tinggi,
  //     'gender': gender,
  //   };
  // }
}