import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:guidedlayout2_1748/Home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guidedlayout2_1748/View/register.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
  final url = Uri.parse('http://10.0.2.2:8000/api/login');
  //final url = Uri.parse('http:/192.168.18.14/api/login');
  try {
    // Tampilkan loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    // Siapkan data body
    final body = {
      'username': usernameController.text.isNotEmpty
          ? usernameController.text
          : null,
      'email': emailController.text.isNotEmpty
          ? emailController.text
          : null,
      'password': passwordController.text,
    };
    body.removeWhere((key, value) => value == null);

    // Kirim permintaan ke API
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(body),
    );

    // Tutup loading dialog
    Navigator.of(context).pop();

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      // Simpan token ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);

      // Tampilkan toast sukses
      Fluttertoast.showToast(
        msg: "Login berhasil!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Navigasi ke HomeView
      Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomeView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Awal transisi dari kanan
          const end = Offset.zero;       // Akhir transisi di tengah
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
    } else {
      final error = jsonDecode(response.body)['message'] ?? 'Login gagal';

      // Tampilkan toast error
      Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Tampilkan dialog error
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Login Gagal'),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  } catch (e) {
    Navigator.of(context).pop();

    // Tampilkan toast error koneksi
    Fluttertoast.showToast(
      msg: 'Gagal terhubung ke server: $e',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // Tampilkan dialog error koneksi
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text('Gagal terhubung ke server: $e'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header teks
                const Text(
                  'Hey there,',
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                ),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),

                // Container input form
                Container(
                  width: 350,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFB0E0E6), Color(0xFFE0BBE4)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey, // Menyimpan status form
                    child: Column(
                      children: [
                        // Input username
                          TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            hintText: "Username",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Username tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Input email
                          TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Input password
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Link lupa password
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              debugPrint("Forgot Password Clicked");
                            },
                            child: const Text(
                              'Forgot your password?',
                              style: TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Tombol Login
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A5ACD),
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    // Validasi form
                    if (_formKey.currentState!.validate()) {
                      login(); // Panggil fungsi login
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Garis pembatas dengan teks "Or"
                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Or", style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 10),

                // Tombol media sosial
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                      onPressed: () {
                        debugPrint("Google Login Clicked");
                      },
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                      onPressed: () {
                        debugPrint("Facebook Login Clicked");
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Link Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Belom punya akun ? "),
                    TextButton(
                      onPressed: () {
                          Fluttertoast.showToast(
                          msg: "Silahkan Registrasi...",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterView()),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Color(0xFF8A2BE2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
