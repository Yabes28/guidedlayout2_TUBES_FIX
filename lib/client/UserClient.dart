import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:guidedlayout2_1748/entity/user.dart';

class UserClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/user';
  // static final String registerEndpoint = '/api/register';
  // static final String loginEndpoint = '/api/login';
  // static final String userEndpoint = '/api/user';
  // static final String updateUserEndpoint = '/api/update';
  // static final String deleteUserEndpoint = '/api/delete';

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
        Uri.http(url, endpoint),
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
      var response = await http.get(Uri.http(url, endpoint));

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
      var response = await http.delete(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<User> fetchUserProfile(String token) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/user'); // Endpoint API Anda
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is Map<String, dynamic>) {
        // Konversi JSON ke objek User
        return User.fromJson(data);
      } else if (data is List && data.isNotEmpty) {
        // Jika respons adalah List, ambil elemen pertama
        return User.fromJson(data[0]);
      } else {
        throw Exception('Unexpected data format');
      }
    } else {
      throw Exception('Failed to fetch user profile');
    }
  }

// Fungsi untuk melakukan update profile
  static Future<http.Response> updateUserProfile(User user) async {
  try {
    var response = await http.put(Uri.http(url, '$endpoint/${user.id}'),
      body: user.toRawJson(),
      headers: {'Content-Type': 'application/json'},
    );

    // Memeriksa status code dari response
    if (response.statusCode != 200) throw Exception(response.reasonPhrase);
    
    return response;
  } catch (e) {
    return Future.error(e.toString());
  }
}

}