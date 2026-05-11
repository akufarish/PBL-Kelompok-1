import 'package:admin_pegawai/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    // Watch provider untuk perubahan data
    final userProvider = context.watch<UserProvider>();
    // Misal: List<User> users = userProvider.listUsers;

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
            onPressed: () =>
                doLogout(context), // Pastikan mengirim context jika menggunakan StatelessWidget
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
                      "Data Akun",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.withOpacity(0.2)),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari Akun...',
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Implementasi List dinamis (Contoh jika ada list data di provider)
                    // users.map((u) => _buildAccountItem(u.name, u.role)).toList(),
                    _buildAccountItem("Aka Demi", "Admin Akademik"),
                    _buildAccountItem("Vega Wai", "Admin Pegawai"),
                    _buildAccountItem("Keluangan", "Admin Keuangan"),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildAccountItem(String name, String role) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFFF0F0F0),
              child: Icon(Icons.person, color: Colors.grey),
            ),
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFF233D90),
            indent: 15,
            endIndent: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Role"),
                Text(role, style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
