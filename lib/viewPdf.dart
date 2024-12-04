import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';


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

  Future<Uint8List> _createPdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) => pw.Center(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text('Detail Pembelian',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Nama Kelas: $className',
                  style: pw.TextStyle(fontSize: 18)),
              pw.Text('Harga: $price', style: pw.TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );

    return pdf.save();
  }
}
