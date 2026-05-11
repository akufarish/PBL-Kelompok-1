import 'package:admin_pegawai/models/user.dart';
import 'package:admin_pegawai/providers/user_provider.dart';
import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: DashboardPage());
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<UserProvider>().profile();
      context.read<UserProvider>().fetchUserCount();
    });
  }

  void doLogout() async {
    final provider = context.read<UserProvider>();
    bool isSuccess = await provider.logout();

    if (!mounted) return;

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
    final UserProvider userProvider = context.watch<UserProvider>();
    final UserResponse? user = userProvider.data;
    debugPrint("Data user ${user}");

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () => doLogout(),
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
                    Text(
                      "Selamat Datang, ${user?.name ?? 'A'}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Lagi mau ngapain nih?",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),

                    // Card Total Akun (Satu baris penuh sesuai desain)
                    CardCount(
                      icon: Icons.admin_panel_settings,
                      label: "TOTAL AKUN",
                      total: userProvider
                          .totalUser, // Nanti bisa ambil dari provider jika ada datanya
                    ),

                    const SizedBox(height: 32),
                    const Text(
                      "Data Akun Terbaru",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // List Akun Terbaru (Vertical List)
                    _buildAccountItem("Aka Demi", "Admin Akademik"),
                    _buildAccountItem("Maha Sigma", "Admin Mahasiswa"),
                    _buildAccountItem("Vega Wai", "Admin Pegawai"),

                    const SizedBox(height: 30),
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

class CardCount extends StatelessWidget {
  final IconData icon;
  final String label;
  final int total;

  const CardCount({
    super.key,
    required this.icon,
    required this.label,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Dibuat penuh sesuai desain
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF233D90), // Warna biru tua sesuai desain
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF233D90), size: 28),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                total.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
