import 'dart:convert'; // Untuk parsing JSON
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Untuk integrasi API
import 'package:guidedlayout2_1748/View/login.dart'; // Navigasi ke halaman Login

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>(); // Key untuk validasi form
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _gender = "laki-laki"; // Gender default sesuai validasi Laravel

  // Fungsi untuk register ke API Laravel
  Future<void> register() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/register'); // Endpoint register Laravel
    try {
      // Tampilkan dialog loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Kirim data ke API
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Header untuk JSON
          'Accept': 'application/json', // Header tambahan untuk Laravel
        },
        body: jsonEncode({
          'username': usernameController.text, // Kirim username
          'email': emailController.text, // Kirim email
          'password': passwordController.text, // Kirim password
          'password_confirmation': passwordController.text, // Konfirmasi password
          'berat': weightController.text, // Kirim berat badan
          'tinggi': heightController.text, // Kirim tinggi badan
          'gender': _gender, // Kirim gender
        }),
      );

      // Tutup dialog loading
      Navigator.of(context).pop();

      if (response.statusCode == 201) {
        // Jika registrasi berhasil, tampilkan dialog sukses
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Registration Successful'),
            content: const Text('Please login to continue'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginView()),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Jika registrasi gagal, tampilkan pesan error
        final error = jsonDecode(response.body)['message']; // Parsing pesan error
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Error'),
            content: Text(error ?? 'Unknown error occurred'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Tutup dialog loading jika ada error
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to connect to server: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
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
      backgroundColor: Colors.white, // Warna latar belakang
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header teks
                const Text(
                  'Hey there,',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
                const Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Form Container
                Container(
                  width: 350,
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFB0E0E6), Color(0xFFE0BBE4)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey, // Menghubungkan form ke validasi
                    child: Column(
                      children: [
                        // Input Username
                        _buildInputField(
                          hint: "User",
                          icon: Icons.person,
                          controller: usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username cannot be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        // Input Email
                        _buildInputField(
                          hint: "Email",
                          icon: Icons.email,
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email cannot be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        // Input Password
                        _buildInputField(
                          hint: "Password",
                          icon: Icons.lock,
                          controller: passwordController,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password cannot be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        // Input Berat
                        _buildInputField(
                          hint: "Your Weight (KG)",
                          icon: Icons.monitor_weight,
                          controller: weightController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Weight cannot be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        // Input Tinggi
                        _buildInputField(
                          hint: "Your Height (CM)",
                          icon: Icons.height,
                          controller: heightController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Height cannot be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        // Pilihan Gender
                        Row(
                          children: [
                            _buildGenderRadio("laki-laki"),
                            const SizedBox(width: 10),
                            _buildGenderRadio("perempuan"),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Tombol Register
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              register(); // Panggil fungsi register
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 120, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: const Color(0xFF6A5ACD),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginView()),
                        );
                      },
                      child: const Text(
                        'Login',
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

  // Helper untuk membuat input field
  Widget _buildInputField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  // Helper untuk pilihan gender
  Widget _buildGenderRadio(String gender) {
    return Row(
      children: [
        Radio<String>(
          value: gender,
          groupValue: _gender,
          onChanged: (String? value) {
            setState(() {
              _gender = value!;
            });
          },
        ),
        Text(gender),
      ],
    );
  }
}
