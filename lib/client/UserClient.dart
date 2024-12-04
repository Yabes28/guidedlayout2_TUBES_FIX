import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:guidedlayout2_1748/entity/user.dart';

class UserClient {
  static final String url = '10.0.2.2:8000';
  static final String registerEndpoint = '/api/register';
  static final String loginEndpoint = '/api/login';
  static final String usersEndpoint = '/api/users';
  static final String updateUserEndpoint = '/api/update';
  static final String deleteUserEndpoint = '/api/delete';

  // Register new user
  // static Future<User> register(User user) async {
  //   try {
  //     var response = await http.post(
  //       Uri.http(url, registerEndpoint),
  //       headers: {"Content-Type": "application/json"},
  //       body: json.encode(user.toJson()),
  //     );

  //     if (response.statusCode != 201) throw Exception(response.reasonPhrase);

  //     return User.fromJson(json.decode(response.body)['user']);
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  // }

  // Login user
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      var response = await http.post(
        Uri.http(url, loginEndpoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return json.decode(response.body);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Show all users
  static Future<List<User>> fetchAll() async {
    try {
      var response = await http.get(Uri.http(url, usersEndpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body);
      return list.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Update user
  // static Future<User> update(User user) async {
  //   try {
  //     var response = await http.put(
  //       Uri.http(url, '$updateUserEndpoint/${user.id}'),
  //       headers: {"Content-Type": "application/json"},
  //       body: json.encode(user.toJson()),
  //     );

  //     if (response.statusCode != 200) throw Exception(response.reasonPhrase);

  //     return User.fromJson(json.decode(response.body));
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  // }

  // Delete user
  static Future<void> delete(String id) async {
    try {
      var response = await http.delete(Uri.http(url, '$deleteUserEndpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}

Future<User> fetchUserProfile() async {
  final url = Uri.parse('http://10.0.2.2:8000/api/user');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    if(jsonData.isNotEmpty){
      return User.fromJson(jsonData[0]);
    }else{
      throw Exception('No user data avaiable');
    }
   
  } else {
    throw Exception('Failed to load profile');
  }
}

// Fungsi untuk melakukan update profile
Future<void> updateUserProfile(String id, Map<String, dynamic> updatedData) async {
  final url = Uri.parse('http://10.0.2.2:8000/api/user/$id');  // Menambahkan ID ke URL
  try {
    final response = await http.put(
      url,
      body: json.encode(updatedData),
      headers: {'Content-Type': 'application/json'},
    );

    // Memeriksa status code dari response
    if (response.statusCode == 200) {
      print('Profile updated successfully  ${response.body} ');
    } else {
      print('Failed to update profile: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}