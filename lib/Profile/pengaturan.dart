import 'package:flutter/material.dart';
import 'package:guidedlayout2_1748/View/login.dart';

// Halaman Pengaturan
class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Setting',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BahasaPage()),
              );
            },
            child: SettingsItem(icon: Icons.language, title: 'Bahasa'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TemaPage()),
              );
            },
            child: SettingsItem(icon: Icons.brightness_6, title: 'Tema'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KontakPage()),
              );
            },
            child: SettingsItem(icon: Icons.contact_mail, title: 'Kontak'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TentangPage()),
              );
            },
            child: SettingsItem(icon: Icons.info, title: 'Tentang'),
          ),
          SizedBox(height: 20),
          LogoutButton(),
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;

  SettingsItem({required this.icon, required this.title});

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
          Expanded(child: Text(title, style: TextStyle(fontSize: 16))),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
        ],
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke LoginView() dan mengganti layar saat ini
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginView()),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Log out',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            SizedBox(width: 5),
            Icon(Icons.logout, color: Colors.red),
          ],
        ),
      ),
    );
  }
}

// Halaman Bahasa
class BahasaPage extends StatefulWidget {
  @override
  _BahasaPageState createState() => _BahasaPageState();
}

class _BahasaPageState extends State<BahasaPage> {
  String _selectedLanguage = 'Indonesia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Setting',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Bahasa aplikasi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          LanguageOption(
            flagIcon: Icons.flag, // Anda dapat mengganti dengan ikon bendera Indonesia jika tersedia
            language: 'Indonesia',
            isSelected: _selectedLanguage == 'Indonesia',
            onTap: () {
              setState(() {
                _selectedLanguage = 'Indonesia';
              });
            },
          ),
          LanguageOption(
            flagIcon: Icons.flag, // Anda dapat mengganti dengan ikon bendera Inggris jika tersedia
            language: 'English',
            isSelected: _selectedLanguage == 'English',
            onTap: () {
              setState(() {
                _selectedLanguage = 'English';
              });
            },
          ),
        ],
      ),
    );
  }
}

class LanguageOption extends StatelessWidget {
  final IconData flagIcon;
  final String language;
  final bool isSelected;
  final VoidCallback onTap;

  LanguageOption({
    required this.flagIcon,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(flagIcon, color: isSelected ? Colors.white : Colors.black),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                language,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Tema
class TemaPage extends StatefulWidget {
  @override
  _TemaPageState createState() => _TemaPageState();
}

class _TemaPageState extends State<TemaPage> {
  String _selectedTheme = 'Mode Terang';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Setting',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Tema',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          ThemeOption(
            icon: Icons.wb_sunny,
            theme: 'Mode Terang',
            isSelected: _selectedTheme == 'Mode Terang',
            onTap: () {
              setState(() {
                _selectedTheme = 'Mode Terang';
              });
            },
          ),
          ThemeOption(
            icon: Icons.nights_stay,
            theme: 'Mode Gelap',
            isSelected: _selectedTheme == 'Mode Gelap',
            onTap: () {
              setState(() {
                _selectedTheme = 'Mode Gelap';
              });
            },
          ),
        ],
      ),
    );
  }
}

class ThemeOption extends StatelessWidget {
  final IconData icon;
  final String theme;
  final bool isSelected;
  final VoidCallback onTap;

  ThemeOption({
    required this.icon,
    required this.theme,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.black),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                theme,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Kontak
class KontakPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Setting',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Kontak',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.blue),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        '+62 7878908767',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                // Divider(color: Colors.grey[300], thickness: 1),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.email, color: Colors.blue),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        'gymin@gmail.com',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContactOption extends StatelessWidget {
  final IconData icon;
  final String contact;

  ContactOption({required this.icon, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              contact,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

// Halaman Tentang
class TentangPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Setting',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tentang',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  '''**GYM IN** adalah aplikasi gym dan pelacak kebugaran yang dirancang untuk membantu Anda mencapai tujuan kesehatan dan kebugaran dengan cara yang efektif. Baik Anda pemula di gym atau seorang atlet berpengalaman, FitLife menyediakan alat yang Anda butuhkan untuk merencanakan, melacak, dan memaksimalkan latihan Anda.

                  **Ubah Gaya Hidup Anda dengan GYM IN**
                  FitLife adalah partner kebugaran digital Anda yang membantu mengelola rutinitas gym, melacak kemajuan, dan memberikan motivasi setiap hari. Dapatkan akses ke rencana latihan yang dipersonalisasi, pelacakan kemajuan, serta panduan latihan yang dikurasi oleh pelatih kebugaran profesional. Dengan GYM IN, Anda dapat membawa gym ke genggaman tangan Anda.

                  **Mengapa Memilih GYM IN?**
                  - **Tepat Sasaran**: Kami memahami bahwa setiap orang memiliki tujuan kebugaran yang berbeda. Dengan GYM IN, Anda dapat membuat dan menyesuaikan rencana yang tepat untuk Anda.
                  - **Tingkatkan Motivasi**: Pantau pencapaian Anda secara real-time dan raih lencana setiap kali Anda mencapai target kebugaran baru.
                  - **Latihan di Mana Saja**: Gunakan aplikasi di gym, di rumah, atau di luar ruangan. Tidak perlu pelatih pribadi, karena GYM IN selalu siap untuk membimbing Anda.
                  ---

                  Stay Fit, Stay Strong
                  ''',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    height: 1.5,
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
