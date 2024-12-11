import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:guidedlayout2_1748/entity/user.dart';
import 'dart:io';

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
  // static Future<User> update(User user, String token, File? image) async {
  //   try {
  //     var uri = Uri.parse('http://10.0.2.2:8000/api/user/${user.id}');
  //     var request = http.MultipartRequest('PUT', uri)
  //       ..headers['Authorization'] = 'Bearer $token'
  //       ..fields['username'] = user.username
  //       ..fields['berat'] = user.berat.toString()
  //       ..fields['tinggi'] = user.tinggi.toString();

  //     if (image != null) {
  //       request.files.add(await http.MultipartFile.fromPath('image', image.path));
  //     }

  //     var response = await request.send();

  //     if (response.statusCode == 200) {
  //       final responseBody = await response.stream.bytesToString();
  //       return User.fromJson(json.decode(responseBody));
  //     } else {
  //       throw Exception('Failed to update profile: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  // }

//   static Future<void> update(User user, String token, File? image) async {
//   try {
//     if (user.username.isEmpty || user.berat == 0 || user.tinggi == 0) {
//       throw Exception('Data is incomplete!');
//     }

//     var uri = Uri.parse('http://10.0.2.2:8000/api/user/${user.id}');
//     var request = http.MultipartRequest('PUT', uri)
//       ..headers['Authorization'] = 'Bearer $token'
//       ..fields['username'] = user.username
//       ..fields['berat'] = user.berat.toString()
//       ..fields['tinggi'] = user.tinggi.toString();

//     // Debugging: Print fields to ensure data is being sent
//     print("Username: ${user.username}");
//     print("Berat: ${user.berat}");
//     print("Tinggi: ${user.tinggi}");

//     // Jika ada gambar
//     if (image != null) {
//       print("Image Path: ${image.path}");
//       request.files.add(await http.MultipartFile.fromPath('image', image.path));
//     } else {
//       print("No image provided.");
//     }

//     var response = await request.send();

//     if (response.statusCode == 200) {
//       final responseBody = await response.stream.bytesToString();
//       final jsonResponse = json.decode(responseBody);
//       print('Updated User: ${jsonResponse['user']}');
//     } else {
//       final responseBody = await response.stream.bytesToString();
//       print('Error updating profile: ${response.statusCode}, $responseBody');
//       throw Exception('Failed to update profile: ${response.statusCode}');
//     }
//   } catch (e) {
//     print("Error: $e");
//   }
// }
//ini
// static Future<void> update(User user, String token, File? image) async {
//   try {
//     var uri = Uri.parse('http://10.0.2.2:8000/api/user/${user.id}');
    
//     var request = http.MultipartRequest('PUT', uri)
//       ..headers['Authorization'] = 'Bearer $token'
//       // Mengirim data pengguna sebagai form fields
//       ..fields['username'] = user.username
//       ..fields['berat'] = user.berat.toString()
//       ..fields['tinggi'] = user.tinggi.toString();

//     // Jika ada gambar, kirim gambar sebagai file
//     if (image != null) {
//       print("Image Path: ${image.path}");
//       request.files.add(await http.MultipartFile.fromPath('image', image.path));
//     } else {
//       print("No image provided.");
//     }

//     // Kirim request dan terima response
//     var response = await request.send();

//     if (response.statusCode == 200) {
//       final responseBody = await response.stream.bytesToString();
//       final jsonResponse = json.decode(responseBody);
//       print('User updated successfully');
//       print('Updated User: ${jsonResponse['user']}');
//     } else {
//       final responseBody = await response.stream.bytesToString();
//       print('Error updating profile: ${response.statusCode}, $responseBody');
//       throw Exception('Failed to update profile: ${response.statusCode}');
//     }
//   } catch (e) {
//     print("Error: $e");
//   }
// }


static Future<void> update(User user, String token) async {
  try {
    var uri = Uri.parse('http://10.0.2.2:8000/api/user/${user.id}');
    var response = await http.put(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',  // Pastikan header Content-Type adalah application/json
      },
      body: json.encode({
        'username': user.username,
        'berat': user.berat,
        'tinggi': user.tinggi,
      }),
    );

    if (response.statusCode == 200) {
      print('User updated successfully');
      final responseBody = json.decode(response.body);
      print('Updated User: ${responseBody['user']}');
    } else {
      final responseBody = json.decode(response.body);
      print('Error updating profile: ${responseBody['message']}');
      throw Exception('Failed to update profile: ${response.statusCode}');
    }
  } catch (e) {
    print("Error: $e");
  }
}


static Future<void> updateUserFoto(User user, File image, String token) async {
    try {
      var uri = Uri.parse('http://10.0.2.2:8000/api/user/foto/${user.id}');

      // Membuat request multipart untuk mengirimkan file gambar
      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token' // Menambahkan token untuk autentikasi
        ..files.add(await http.MultipartFile.fromPath('foto', image.path)); // Menambahkan file gambar

      // Mengirimkan request
      var response = await request.send();

      // Memeriksa apakah status code response adalah 200 (berhasil)
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('User photo updated successfully');
        print('Response: $responseBody');
      } else {
        final responseBody = await response.stream.bytesToString();
        print('Error updating photo: ${response.statusCode}, $responseBody');
        throw Exception('Failed to update user photo: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

static Future<void> deleteUserFoto(User user, String token) async {
  try {
    var uri = Uri.parse('http://10.0.2.2:8000/api/user/foto/${user.id}');

    var response = await http.delete(
      uri,
      headers: {
        'Authorization': 'Bearer $token',  // Menambahkan token untuk autentikasi
      },
    );

    // Memeriksa status code response
    if (response.statusCode == 200) {
      print('User photo deleted successfully');
    } else {
      print('Error deleting photo: ${response.statusCode}, ${response.body}');
      throw Exception('Failed to delete user photo: ${response.statusCode}');
    }
  } catch (e) {
    print("Error: $e");
  }
}



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
//   static Future<http.Response> updateUserProfile(User user) async {
//   try {
//     var response = await http.put(Uri.http(url, '$endpoint/${user.id}'),
//       body: user.toRawJson(),
//       headers: {'Content-Type': 'application/json'},
//     );

//     // Memeriksa status code dari response
//     if (response.statusCode != 200) throw Exception(response.reasonPhrase);
    
//     return response;
//   } catch (e) {
//     return Future.error(e.toString());
//   }
// }

}