import 'package:flutter/material.dart';
import 'package:guidedlayout2_1748/Profile/editProfile.dart';
import 'package:guidedlayout2_1748/Profile/pengaturan.dart';
import 'package:guidedlayout2_1748/Profile/review.dart';
import 'package:guidedlayout2_1748/Profile/histori.dart';
import 'package:guidedlayout2_1748/Profile/Camera/qr_scan.dart';
import 'package:guidedlayout2_1748/entity/user.dart'; // Import model User
import 'package:guidedlayout2_1748/client/UserClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User> _userProfile;
  int _keaktifanPoin = 1001; // Inisialisasi nilai awal poin keaktifan

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  void _fetchUserProfile() {
    setState(() {
      _userProfile = _getUserProfile();
    });
  }

  Future<User> _getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) {
      throw Exception('Token not found');
    }
    return UserClient.fetchUserProfile(token);
  }

  // Fungsi untuk menangani pemindaian QR Code
  void _onQrCodeScanned() {
    setState(() {
      _keaktifanPoin += 10; // Tambahkan 10 poin keaktifan setelah scanning
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('QR Code berhasil dipindai! Keaktifan +10')),
    );
  }

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PengaturanPage()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<User>(
            future: _userProfile,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final user = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user.username,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          final isUpdated = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditProfilePage()),
                          );
                          if (isUpdated == true) {
                            _fetchUserProfile();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ProfileInfoCard(
                              title: 'Tinggi',
                              value: user.tinggi.toString()),
                          const SizedBox(width: 10),
                          ProfileInfoCard(
                              title: 'Berat', value: user.berat.toString()),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ProfileMenuItem(
                          icon: Icons.check_circle,
                          title: 'Keaktifan',
                          value: '$_keaktifanPoin'),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ReviewPage()),
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
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HistoryPage()),
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
                return const Center(child: Text('No data found'));
              }
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () async {
                // Simulasi pemindaian QR Code
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BarcodeScannerPageView()),
                ).then((value) {
                  if (value == true) {
                    _onQrCodeScanned(); // Tambahkan poin setelah QR Code berhasil dipindai
                  }
                });
              },
              backgroundColor: Colors.blue,
              child: Image.asset(
                'assets/scanner.png',
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