import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = '10.0.2.2.8000';
  // Ganti IP dengan IP Anda
  String? token;

  // Fungsi untuk mendapatkan token dari local storage
  Future<void> _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? storedToken = localStorage.getString('token');

    if (storedToken != null) {
      try {
        token = jsonDecode(storedToken)['token'];
      } catch (e) {
        token = null; // Jika parsing gagal, set token ke null
        print('Error decoding token: $e');
      }
    }
  }

  // Fungsi untuk autentikasi (POST)
  Future<http.Response> auth(Map<String, dynamic> data, String apiURL) async {
    var fullUrl = '$_url$apiURL';
    return await http.post(
      Uri.parse(fullUrl), // Gunakan Uri.parse
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  // Fungsi untuk mengambil data (GET)
  Future<http.Response> getData(String apiURL) async {
    var fullUrl = '$_url$apiURL';
    await _getToken(); // Dapatkan token sebelum mengirim permintaan
    return await http.get(
      Uri.parse(fullUrl), // Gunakan Uri.parse
      headers: _setHeaders(),
    );
  }

  // Header untuk permintaan
  Map<String, String> _setHeaders() {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token', // Hanya tambahkan Authorization jika token tidak null
    };
  }
}
