import 'package:admin_pegawai/providers/user_provider.dart';
import 'package:admin_pegawai/screens/auth_screen.dart';
import 'package:admin_pegawai/screens/detail_screen.dart';
import 'package:admin_pegawai/screens/main_screen.dart';
import 'package:admin_pegawai/screens/reset_screen.dart';
import 'package:admin_pegawai/utils/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Pindahkan ke paling atas
  await dotenv.load();

  String? token = await TokenManager.getAccessToken();
  Widget initialScreen = const AuthScreen();

  if (token != null && !JwtDecoder.isExpired(token)) {
    initialScreen = const MainScreen();
  }

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MainApp(screen: initialScreen),
    ),
  );
}

class MainApp extends StatelessWidget {
  final Widget screen;
  const MainApp({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      // Hapus Scaffold(body: screen), langsung panggil screen saja
      home: screen,
      routes: {
        "/login": (context) => const AuthScreen(),
        "/dashboard": (context) => const MainScreen(),
        "/detail-akun": (context) => const DetailAkunScreen(),
        "/reset-screen": (context) => ResetScreen(),
      },
    );
  }
}
