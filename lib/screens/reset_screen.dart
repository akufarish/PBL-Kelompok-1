import 'package:admin_pegawai/models/user.dart';
import 'package:admin_pegawai/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void doLogout(BuildContext context) async {
    final provider = context.read<UserProvider>();
    bool isSuccess = await provider.logout();

    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    }
  }

  void doReset(BuildContext context) async {
    final provider = context.read<UserProvider>();

    ResetPassword resetPassword = ResetPassword(
      email: emailController.text,
      newPassword: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    bool isSuccess = await provider.resetUser(resetPassword);

    if (isSuccess) {
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(title: Text("Password berhasil diganti")),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(title: Text("Gagal ganti password")),
      );
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
        title: Row(
          children: [
            Image.asset(
              'assets/logo/logo.png',
              height: 60, // Sesuaikan tinggi agar serasi dengan teks
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10), // Memberi jarak antara logo dan teks
            Text(
              'SABAR', // Ganti dengan teks yang kamu inginkan
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
            onPressed: () => doLogout(
              context,
            ), // Pastikan mengirim context jika menggunakan StatelessWidget
          ),
        ],
      ),
      body: userProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Reset Password",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),

                    // Container Form
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("Email"),
                          _buildTextField(emailController, "Isi Email.."),

                          const SizedBox(height: 16),
                          _buildLabel("Password Baru"),
                          _buildTextField(
                            passwordController,
                            "Isi Password..",
                            isPassword: true,
                          ),

                          const SizedBox(height: 16),
                          _buildLabel("Konfirmasi Password Baru"),
                          _buildTextField(
                            confirmPasswordController,
                            "Konfirmasi Password..",
                            isPassword: true,
                          ),

                          const SizedBox(height: 24),

                          // Button Simpan
                          SizedBox(
                            width: 120,
                            child: ElevatedButton.icon(
                              onPressed: () => doReset(context),
                              icon: const Icon(
                                Icons.save,
                                size: 18,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Simpan",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                  0xFF27AE60,
                                ), // Warna hijau sesuai gambar
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
