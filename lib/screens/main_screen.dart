import 'package:admin_pegawai/screens/dashboard_screen.dart';
import 'package:admin_pegawai/screens/account_screen.dart';
import 'package:admin_pegawai/screens/profile_screen.dart';
import 'package:admin_pegawai/screens/reset_screen.dart';
import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Dashboard(),
    AccountScreen(),
    ResetScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt_1),
            label: 'Akun',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.vpn_key), label: 'Reset'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
