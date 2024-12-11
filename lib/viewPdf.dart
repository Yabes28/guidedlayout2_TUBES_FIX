import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

class ViewPdf extends StatefulWidget {
  final String className; // Nama kelas dari AbsPage
  final double price; // Harga kelas dari AbsPage

  const ViewPdf({
    Key? key,
    required this.className,
    required this.price,
  }) : super(key: key);

  @override
  _ViewPdfState createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  @override
  void initState() {
    super.initState();
    // Tampilkan toast saat halaman dibuka
    Fluttertoast.showToast(
      msg: "Transaksi Berhasil",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Preview PDF',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: PdfPreview(
        build: (format) => _createPdf(format),
      ),
    );
  }

  /// Fungsi untuk mengambil data pengguna dari SharedPreferences
  Future<String> fetchUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) {
      throw Exception("Token not found");
    }

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/user'), // Sesuaikan endpoint
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final user = json.decode(response.body);
      return user['username'] ?? 'Guest';
    } else {
      throw Exception('Failed to load user data');
    }
  }

  /// Fungsi untuk mengambil data dari API `/api/pt`
  Future<List<Person>> fetchPeople() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/pt')); // Sesuaikan endpoint

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse is List) {
        return jsonResponse.map((item) => Person.fromJson(item)).toList();
      } else if (jsonResponse is Map<String, dynamic>) {
        if (jsonResponse['data'] != null && jsonResponse['data'] is List) {
          return (jsonResponse['data'] as List)
              .map((item) => Person.fromJson(item))
              .toList();
        } else {
          throw Exception('Invalid data structure: "data" key not found');
        }
      } else {
        throw Exception('Invalid JSON format');
      }
    } else {
      throw Exception('Failed to load trainers');
    }
  }

  /// Fungsi untuk membuat PDF
  Future<Uint8List> _createPdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    // Ambil data pengguna
    String userName = await fetchUserName();

    // Ambil data dari API
    List<Person> people = await fetchPeople();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Detail Kelas: ${widget.className}',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              'Harga: Rp. ${widget.price.toStringAsFixed(2)}',
              style: pw.TextStyle(fontSize: 18),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Transaksi oleh: $userName',
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.blue,
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Daftar Personal Trainer:',
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                // Header tabel
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        'Nama',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        'Harga',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                // Baris data
                ...people.map((person) {
                  return pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(person.nama),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(
                          'Rp. ${person.harga.toStringAsFixed(2)}',
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );

    return pdf.save();
  }
}

class Person {
  final String nama;
  final double harga;

  Person({required this.nama, required this.harga});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      nama: json['nama'] ?? 'Tanpa Nama',
      harga: (json['harga'] as num).toDouble(),
    );
  }
}
