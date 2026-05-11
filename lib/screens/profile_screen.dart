import 'dart:io';

import 'package:admin_pegawai/providers/user_provider.dart';
import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void doLogout(BuildContext context) async {
    final provider = context.read<UserProvider>();
    bool isSuccess = await provider.logout();

    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan saat logout")),
      );
    }
  }

  Future<void> pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      // Pastikan memanggil setProfile sesuai nama fungsi di provider kamu
      context.read<UserProvider>().setProfile(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/logo/logo.png',
              height: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            Text(
              'SABAR',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () => doLogout(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40),
                  const Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: Colors.black87,
                      ),
                      // PERBAIKAN: Menghapus kurung kurawal kosong yang salah
                      onPressed: () => pickImage(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Foto Profil Lingkaran
              Center(
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    // PERBAIKAN: Logika untuk menampilkan FileImage jika ada, 
                    // jika tidak maka tampilkan AssetImage (default/logo)
                    image: DecorationImage(
                      image: userProvider.profileImage != null
                          ? FileImage(userProvider.profileImage!) as ImageProvider
                          : const AssetImage('assets/logo/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              if (userProvider.data != null) ...[
                Text(
                  userProvider.data!.name,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  userProvider.data!.roleName,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}