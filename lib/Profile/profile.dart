import 'package:flutter/material.dart';

import 'package:guidedlayout2_1748/Profile/editProfile.dart';
import 'package:guidedlayout2_1748/Profile/pengaturan.dart';
import 'package:guidedlayout2_1748/Profile/review.dart';
import 'package:guidedlayout2_1748/Profile/histori.dart';
import 'package:guidedlayout2_1748/Profile/Camera/qr_scan.dart';
import 'package:guidedlayout2_1748/entity/user.dart'; // Import model User
import 'package:guidedlayout2_1748/client/UserClient.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {
              // Navigasi ke halaman Pengaturan
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PengaturanPage()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Menggunakan FutureBuilder untuk mengambil data
          FutureBuilder<User>(
            future: fetchUserProfile(),  // Memanggil data profil
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator()); // Loading state
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}')); // Error state
              } else if (snapshot.hasData) {
                final user = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        user.username,  // Menampilkan nama dari API
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Navigasi ke halaman Edit Profile
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditProfilePage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ProfileInfoCard(title: 'Tinggi', value: user.tinggi.toString()),  // Menampilkan tinggi dari API
                          SizedBox(width: 10),
                          ProfileInfoCard(title: 'Berat', value: user.berat.toString()),  // Menampilkan berat dari API
                        ],
                      ),
                      SizedBox(height: 20),
                      ProfileMenuItem(
                          icon: Icons.check_circle, title: 'Keaktifan', value: '1001'),
                      // ProfileMenuItem(
                      //     icon: Icons.badge, title: 'Badge', value: '1001'),
                      // ProfileMenuItem(
                      //     icon: Icons.star, title: 'Poin', value: '1001'),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReviewPage()),
                                );
                              },
                              child: ProfileMenuItem(
                                icon: Icons.rate_review,
                                title: 'Review',
                                value: '',
                                showArrow: true,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HistoryPage()),
                                );
                              },
                              child: ProfileMenuItem(
                                icon: Icons.history,
                                title: 'Riwayat',
                                value: '',
                                showArrow: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: Text('No data found'));
              }
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                // Tambahkan aksi untuk ikon QR Code
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BarcodeScannerPageView()),
                );
                print("QR Code Pressed");
              },
              backgroundColor: Colors.blue,
              child: Image.asset(
                'images/scanner.png', // Path gambar QR
                fit: BoxFit.cover,
                width: 30,
                height: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final String title;
  final String value;

  ProfileInfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcIn,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool showArrow;

  ProfileMenuItem(
      {required this.icon,
      required this.title,
      required this.value,
      this.showArrow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 20),
          Expanded(
            child: Text(title, style: TextStyle(fontSize: 16)),
          ),
          Text(value, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          if (showArrow)
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
        ],
      ),
    );
  }
}