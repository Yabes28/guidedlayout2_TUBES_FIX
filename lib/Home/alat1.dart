import 'package:flutter/material.dart';

class Alat1Page extends StatelessWidget {
  const Alat1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        title: const Text('Alat'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar alat
              Image.asset(
                'assets/benchpress.jpg', // Ganti dengan path gambar Anda
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              // Nama alat
              const Text(
                'Bench Press',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Deskripsi penggunaan alat
              const Text(
                'Cara Menggunakan Bench Press\n\n'
                '1. Pastikan bench press stabil dan terpasang dengan benar.\n'
                '2. Siapkan barbell dengan beban yang sesuai dengan kemampuanmu.\n'
                '3. Berbaring telentang di bench press, pastikan kaki rata di lantai untuk kestabilan.\n'
                '4. Posisi tubuh harus lurus, kepala, punggung atas, dan bokong menempel di bangku.\n'
                '5. Pegang barbell dengan tangan selebar bahu atau sedikit lebih lebar.\n'
                '6. Pastikan pergelangan tangan stabil dan tidak bengkok saat menggenggam barbell.\n'
                '7. Angkat barbell dari rak hingga posisi lengan lurus di atas dada.\n'
                '8. Turunkan barbell perlahan ke arah dada, pastikan siku membentuk sudut 45-75 derajat dengan tubuh.\n'
                '9. Barbell harus turun ke tengah dada, jangan terlalu tinggi atau rendah.\n'
                '10. Dorong barbell ke atas dengan kontrol hingga kembali ke posisi awal.\n'
                '11. Jangan mendorong dengan punggung bawah atau melengkungkan tubuh.\n'
                '12. Pastikan gerakan terkendali, baik saat turun maupun naik.\n'
                '13. Fokus pada pernapasan: tarik napas saat menurunkan barbell dan hembuskan napas saat mendorong barbell ke atas.\n'
                '14. Mulailah dengan 3 set 8-12 repetisi untuk pemula.\n'
                '15. Tingkatkan beban secara bertahap seiring peningkatan kekuatan.\n'
                '16. Setelah selesai, kembalikan barbell dengan hati-hati ke rak.\n'
                '17. Lakukan pendinginan dengan peregangan untuk mencegah cedera otot.\n'
                '18. Gunakan collar atau pengunci beban di kedua sisi barbell agar beban tidak tergelincir.\n'
                '19. Jangan berlatih bench press sendirian jika belum berpengalaman, spotter sangat disarankan.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              // Tombol untuk kembali
              Center(
                child: SizedBox(
                  width: double.infinity, // Membuat tombol selebar layar
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Kembali ke halaman sebelumnya
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF92A3FD), // Warna tombol
                      padding: const EdgeInsets.symmetric(vertical: 16), // Tinggi tombol
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Membuat sudut tombol melengkung
                      ),
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}