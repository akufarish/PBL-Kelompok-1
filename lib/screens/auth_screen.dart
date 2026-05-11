import 'package:admin_pegawai/models/user.dart';
import 'package:admin_pegawai/providers/user_provider.dart';
import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _showModal() {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColors.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const SizedBox(height: 300, child: LoginForm()),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      _showModal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/logo/logo.png"),
                width: 285,
                height: 285,
              ),
              Text(
                'SABAR',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: AppColors.backgroundColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 28
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void doLogin() async {
    final provider = context.read<UserProvider>();

    LoginRequest loginRequest = LoginRequest(
      email: _emailController.text,
      password: _passwordController.text,
    );

    bool isSuccess = await provider.login(loginRequest);

    if (!mounted) return;

    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/dashboard",
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Email atau password salah")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Login", style: TextStyle(fontSize: 20)),
            SizedBox(height: 19),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.mail, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 19),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.lock, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 19),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: provider.isLoading ? null : doLogin,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: AppColors.primaryColor,
                ),
                child: provider.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
