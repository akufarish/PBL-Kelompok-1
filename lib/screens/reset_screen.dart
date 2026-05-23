import 'package:admin_pegawai/models/user.dart';
import 'package:admin_pegawai/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context)!.settings.arguments as UserResponse?;
    if (user != null) {
      emailController.text = user.email;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Yakin ingin melakukan reset password?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _doReset();
            },
            child: const Text("Yakin"),
          ),
        ],
      ),
    );
  }

  void _doReset() async {
    final provider = context.read<UserProvider>();
    ResetPassword resetPassword = ResetPassword(
      email: emailController.text,
      newPassword: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    bool isSuccess = await provider.resetUser(resetPassword);
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(isSuccess ? "Berhasil" : "Gagal"),
        content: Text(
          isSuccess
              ? "Password berhasil diganti"
              : "Terjadi kesalahan saat mengganti password",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (isSuccess) Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
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
              height: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            Text(
              'SABAR',
              style: GoogleFonts.poppins(color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
      body: userProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
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
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("Email"),
                          TextFormField(
                            controller: emailController,
                            readOnly: true,
                            decoration: _inputDec("Email"),
                          ),
                          const SizedBox(height: 16),
                          _buildLabel("Password Baru"),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: _inputDec("Isi Password.."),
                            validator: (v) => (v == null || v.length < 8)
                                ? "Minimal 8 karakter"
                                : null,
                          ),
                          const SizedBox(height: 16),
                          _buildLabel("Konfirmasi Password Baru"),
                          TextFormField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration: _inputDec("Konfirmasi Password.."),
                            validator: (v) => v != passwordController.text
                                ? "Password tidak cocok"
                                : null,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _showConfirmationDialog();
                              }
                            },
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
                              backgroundColor: const Color(0xFF27AE60),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(fontSize: 16, color: Colors.black87),
    ),
  );

  InputDecoration _inputDec(String hint) => InputDecoration(
    hintText: hint,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
  );
}
