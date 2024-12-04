import 'dart:convert'; // Untuk parsing JSON
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guidedlayout2_1748/Home/home.dart';
import 'package:guidedlayout2_1748/View/register.dart';
import 'package:guidedlayout2_1748/component/form_component.dart';
import 'package:http/http.dart' as http; // Untuk integrasi API

class LoginView extends StatefulWidget {
  final Map? data;
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Key untuk validasi form
  final _formKey = GlobalKey<FormState>();

  // Controller untuk input data
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Map<dynamic, dynamic>? dataForm;

  @override
  void initState() {
    super.initState();
    // Data awal form jika ada (dikirim melalui parameter)
    dataForm = widget.data;
  }

  // Fungsi untuk login ke API Laravel
  Future<void> login() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/login'); // Endpoint login Laravel
    try {
      // Tampilkan indikator loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Kirim data login menggunakan email atau username
      final body = {
        'username': usernameController.text.isNotEmpty
            ? usernameController.text
            : null,
        'email': emailController.text.isNotEmpty
            ? emailController.text
            : null,
        'password': passwordController.text,
      };

      // Hapus nilai null dari body
      body.removeWhere((key, value) => value == null);

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Header untuk JSON
          'Accept': 'application/json', // Header tambahan untuk Laravel
        },
        body: jsonEncode(body),
      );

      // Tutup dialog loading
      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Parsing respons JSON
        final token = data['token']; // Ambil token autentikasi
        debugPrint('Login Successful: Token - $token'); // Debug token

        // Navigasi ke halaman Home
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HomeView()),
        );
      } else {
        final error = jsonDecode(response.body)['message'] ?? 'Login failed';
        // Tampilkan dialog error jika login gagal
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Login Failed'),
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
      // Tutup dialog loading jika ada error koneksi
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to connect to server: $e'),
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
                      colors: [Color(0xFFB0C4DE), Color(0xFF87CEFA)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: _formKey, // Menyimpan status form
                    child: Column(
                      children: [
                        // Input username
                        inputForm(
                          (p0) {
                            if (emailController.text.isEmpty &&
                                (p0 == null || p0.isEmpty)) {
                              return "Username atau Email tidak boleh kosong";
                            }
                            return null;
                          },
                          controller: usernameController,
                          hintTxt: "Username",
                          helperTxt: "",
                          iconData: Icons.person,
                        ),
                        // Input email
                        inputForm(
                          (p0) {
                            if (usernameController.text.isEmpty &&
                                (p0 == null || p0.isEmpty)) {
                              return "Username atau Email tidak boleh kosong";
                            }
                            return null;
                          },
                          controller: emailController,
                          hintTxt: "Email",
                          helperTxt: "",
                          iconData: Icons.email,
                        ),
                        // Input password
                        inputForm(
                          (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return "Password tidak boleh kosong";
                            }
                            return null;
                          },
                          controller: passwordController,
                          hintTxt: "Password",
                          helperTxt: "",
                          iconData: Icons.lock,
                          password: true,
                        ),
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
                    backgroundColor: const Color(0xFF87CEFA),
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
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterView()),
                    );
                  },
                  child: const Text(
                    "Don't have an account yet? Register",
                    style: TextStyle(
                      color: Color(0xFF8A2BE2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
