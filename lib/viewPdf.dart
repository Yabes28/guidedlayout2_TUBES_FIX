import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ViewPdf extends StatelessWidget {
  final String className;
  final double price;

  const ViewPdf({
    Key? key,
    required this.className,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview PDF'),
      ),
      body: PdfPreview(
        build: (format) => _createPdf(format),
      ),
    );
  }

  Future<String> fetchUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception("Token not found");
    }

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/user'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final user = json.decode(response.body);
      return user['username'];
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<Uint8List> _createPdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    // Ambil nama pengguna
    String username = await fetchUserName();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) => pw.Center(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text('Pembelian Oleh: $username',
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Nama Pembelian', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Harga', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(className),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(price.toString()),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return pdf.save();
  }
}