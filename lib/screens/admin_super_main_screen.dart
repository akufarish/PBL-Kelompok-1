import 'package:admin_pegawai/screens/super_dashboard_screen.dart';
import 'package:admin_pegawai/screens/account_screen.dart';
import 'package:admin_pegawai/screens/role_screen.dart';
import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SuperScreen extends StatefulWidget {
  const SuperScreen({super.key});

  @override
  State<SuperScreen> createState() => _SuperScreenState();
}

class _SuperScreenState extends State<SuperScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [SuperDashboard(), AccountScreen(), RoleScreen()];

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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
          BottomNavigationBarItem(icon: Icon(Icons.key), label: 'Role'),
        ],
      ),
    );
  }
}
