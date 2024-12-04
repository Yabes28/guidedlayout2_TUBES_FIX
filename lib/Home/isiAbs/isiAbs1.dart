import 'package:flutter/material.dart';

class isiAbs1 extends StatelessWidget {
  final String title;
  final String imageAsset;

  const isiAbs1({
    Key? key,
    required this.title,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imageAsset,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.timer, color: Color(0xFF92A3FD)),
                const SizedBox(width: 8),
                const Text(
                  '20 min',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Cable Crunch adalah latihan yang bertujuan untuk memperkuat otot abs (terutama bagian rectus abdominis). Latihan ini menggunakan mesin kabel dengan beban yang dapat diatur sesuai kemampuan.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              "Deskripsi Kegiatan:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "1. Posisi Awal:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              "• Mulailah dengan memasang pegangan tali di mesin kabel yang berada di posisi atas.\n"
              "• Berlutut di lantai menghadap mesin, dengan lutut berjarak selebar bahu.\n"
              "• Pegang tali dengan kedua tangan di samping kepala atau sedikit di depan dahi, siku ditekuk. Punggung tetap lurus dan tegak.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 8),
            const Text(
              "2. Gerakan Crunch:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              "• Lakukan gerakan crunch hingga siku hampir menyentuh lutut.\n"
              "• Pastikan hanya otot abs yang bekerja selama gerakan ini, hindari menarik dengan tangan atau menggunakan momentum.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF92A3FD),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Back"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}