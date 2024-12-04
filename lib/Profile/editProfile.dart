import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:guidedlayout2_1748/entity/user.dart';  // Mengimpor User
import 'package:guidedlayout2_1748/client/UserClient.dart';  // Mengimpor fungsi dari client

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

  @override
  void initState() {
    super.initState();
    fetchUserProfileData();
  }

  // Mengambil data profil pengguna
  Future<void> fetchUserProfileData() async {
    try {
      User user = await fetchUserProfile();  // Menggunakan fungsi fetchUserProfile yang diimpor
      setState(() {
        usernameController.text = user.username;
        heightController.text = user.tinggi.toString();
        weightController.text = user.berat.toString();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error loading profile: $e")));
    }
  }

  // Fungsi untuk memilih gambar profil
  Future<void> pickImage() async {
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

  // Fungsi untuk memperbarui profil pengguna
  Future<void> updateUserProfileData(String userId) async {
    try {
      final updatedData = {
        'username': usernameController.text,
        'berat': int.parse(weightController.text),
        'tinggi': int.parse(heightController.text),
      };
      // Panggil fungsi untuk update profil pengguna
      await updateUserProfile(userId, updatedData);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error updating profile: $e")));
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
      body: usernameController.text.isEmpty // Tampilkan loading jika data belum diisi
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: image != null ? FileImage(image!) : null,
                    child: image == null
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Upload Foto', style: TextStyle(color: Colors.white)),
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
                    onPressed: () => updateUserProfileData(userId),
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