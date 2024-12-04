import 'dart:convert';
import 'package:http/http.dart' as http;

class Alat {
  final String id;
  final String id_layanan;
  final String nama_alat;

  Alat({
    required this.id,
    required this.id_layanan,
    required this.nama_alat,
  });

  factory Alat.fromJson(Map<String, dynamic> json) {
    return Alat(
      id: json['id'].toString(),
      id_layanan: json['id_layanan'].toString(),
      nama_alat: json['nama_alat'],
    );
  }
}

Future<List<Alat>> fetchAlatList() async {
  final url = Uri.parse('http://10.0.2.2:8000/api/alat');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // Parsing response.body yang diharapkan berupa objek dengan key 'data'
    final Map<String, dynamic> jsonData = json.decode(response.body);
    final List<dynamic> alatList = jsonData['data']; // Ambil list alat dari key 'data'
    
    return alatList.map((item) => Alat.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load alat');
  }
}
