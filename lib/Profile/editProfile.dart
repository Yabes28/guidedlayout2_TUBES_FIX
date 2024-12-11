import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:guidedlayout2_1748/entity/user.dart';
import 'package:guidedlayout2_1748/client/UserClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? image;
  TextEditingController usernameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String userId = '';
  String? currentPhoto;

  @override
  void initState() {
    super.initState();
    fetchUserProfileData();
  }

  // Mengambil data profil pengguna
  Future<void> fetchUserProfileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception('Token not found');
      }

      User user = await UserClient.fetchUserProfile(token);
      setState(() {
        userId = user.id;
        usernameController.text = user.username;
        heightController.text = user.tinggi.toString();
        weightController.text = user.berat.toString();
        currentPhoto = user.foto;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error loading profile: $e")));
    }
  }

  // Fungsi untuk memilih gambar profil dari galeri
  Future<void> pickImageFromGallery() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      setState(() {
        image = File(pickedImage.path);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error picking image: $e")));
    }
  }

  // Fungsi untuk mengambil gambar profil menggunakan kamera
  Future<void> pickImageFromCamera() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage == null) return;

      setState(() {
        image = File(pickedImage.path);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error capturing image: $e")));
    }
  }

  // Fungsi untuk memperbarui profil pengguna
  Future<void> updateUserProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Token not found. Please log in again.")));
      return;
    }

    User updatedUser = User(
      id: userId,
      username: usernameController.text,
      berat: int.parse(weightController.text),
      tinggi: int.parse(heightController.text),
    );

    try {
      // Perbarui data pengguna
      await UserClient.update(updatedUser, token);

      if (image != null) {
        // Hapus foto lama jika ada dan unggah foto baru
        if (currentPhoto != null && currentPhoto!.isNotEmpty) {
          await UserClient.deleteUserFoto(updatedUser, token);
        }
        await UserClient.updateUserFoto(updatedUser, image!, token);
      }

      // Ambil data terbaru setelah pembaruan
      await fetchUserProfileData();
      Navigator.pop(context, true);
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating profile: $err")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: usernameController.text.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: image != null
                        ? FileImage(image!)
                        : (currentPhoto != null && currentPhoto!.isNotEmpty
                            ? NetworkImage('http://10.0.2.2:8000/storage/$currentPhoto')
                            : null) as ImageProvider?,
                    child: image == null && (currentPhoto == null || currentPhoto!.isEmpty)
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: pickImageFromGallery,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Upload Foto', style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: pickImageFromCamera,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Ambil Foto', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ProfileTextField(
                    controller: usernameController,
                    icon: Icons.person,
                    label: 'Username',
                  ),
                  ProfileTextField(
                    controller: heightController,
                    icon: Icons.height,
                    label: 'Tinggi (cm)',
                  ),
                  ProfileTextField(
                    controller: weightController,
                    icon: Icons.monitor_weight,
                    label: 'Berat (kg)',
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: updateUserProfileData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                    ),
                    child: const Text('Simpan', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String label;

  const ProfileTextField({
    required this.controller,
    required this.icon,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 20),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: label,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}