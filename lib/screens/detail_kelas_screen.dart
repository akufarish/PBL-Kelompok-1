import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:admin_pegawai/utils/app_colors.dart';

class DetailKelasScreen extends StatefulWidget {
  const DetailKelasScreen({super.key});

  @override
  State<DetailKelasScreen> createState() => _DetailKelasScreenState();
}

class _DetailKelasScreenState extends State<DetailKelasScreen> {
  @override
  Widget build(BuildContext context) {
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
              height: 35,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            Text(
              'SABAR',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    size: 14,
                    color: Colors.black87,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Kembali",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Akademik > Kelas > Detail Kelas",
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Detail Kelas",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Informasi Kelas",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                children: [
                  _buildDetailRow("Nama", "TI-4A"),
                  const Divider(
                    height: 24,
                    thickness: 1,
                    color: Color(0xFFEEEEEE),
                  ),
                  _buildDetailRow("Jurusan", "Teknik Elektro"),
                  const Divider(
                    height: 24,
                    thickness: 1,
                    color: Color(0xFFEEEEEE),
                  ),
                  _buildDetailRow("Prodi", "Teknik Informatika"),
                  const Divider(
                    height: 24,
                    thickness: 1,
                    color: Color(0xFFEEEEEE),
                  ),
                  _buildDetailRow("Tahun Akademik", "2024-2025"),
                  const Divider(
                    height: 24,
                    thickness: 1,
                    color: Color(0xFFEEEEEE),
                  ),
                  _buildDetailRow("Semester", "Genap"),
                  const Divider(
                    height: 24,
                    thickness: 1,
                    color: Color(0xFFEEEEEE),
                  ),
                  _buildDetailRow("Total Mahasiswa", "30 Mahasiswa"),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Informasi Mahasiswa",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                children: [
                  _buildStudentRow("Udin", "C0123xx"),
                  const Divider(
                    height: 24,
                    thickness: 1,
                    color: Color(0xFFEEEEEE),
                  ),
                  _buildStudentRow("Kamarudin", "C0123xx"),
                  const Divider(
                    height: 24,
                    thickness: 1,
                    color: Color(0xFFEEEEEE),
                  ),
                  _buildStudentRow("Rudi", "C0123xx"),
                  const Divider(
                    height: 24,
                    thickness: 1,
                    color: Color(0xFFEEEEEE),
                  ),
                  _buildStudentRow("Sinegar", "C0123xx"),
                  const Divider(
                    height: 24,
                    thickness: 1,
                    color: Color(0xFFEEEEEE),
                  ),
                  _buildStudentRow("Amba", "C0123xx"),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit_note,
                  color: Colors.white,
                  size: 20,
                ),
                label: Text(
                  "Edit",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
          ),
        ),
        Text(
          ":",
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _buildStudentRow(String name, String nim) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            name,
            style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
          ),
        ),
        Text(
          nim,
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
        ),
      ],
    );
  }
}
