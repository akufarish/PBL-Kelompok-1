import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:admin_pegawai/providers/akademik_provider.dart';
import 'package:admin_pegawai/utils/app_colors.dart';

class MatakuliahEditScreen extends StatefulWidget {
  const MatakuliahEditScreen({super.key});

  @override
  State<MatakuliahEditScreen> createState() => _MatakuliahEditScreenState();
}

class _MatakuliahEditScreenState extends State<MatakuliahEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _kodeController;
  late TextEditingController _namaController;
  int _selectedSks = 2;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final mk = context.read<AkademikProvider>().selectedMataKuliah;
      if (mk != null) {
        _kodeController = TextEditingController(text: mk.kode);
        _namaController = TextEditingController(text: mk.name);
        _selectedSks = mk.sks;
      }
      _isInit = false;
    }
  }

  @override
  void dispose() {
    _kodeController.dispose();
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AkademikProvider>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            Image.asset(
              'assets/logo/logo.png',
              height: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            Text(
              'SABAR',
              style: GoogleFonts.poppins(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Row(
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
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Akademik > matakuliah > detail matakuliah > edit matakuliah",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Colors.black45,
                      ),
                    ),
                    Text(
                      "Detail Kurikulum",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "Pembaharuan data kurikulum",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Kontainer Form Utama
                    Container(
                      width: double.infinity,
                      clipBehavior: Clip
                          .antiAlias, // 👈 SOLUSI: Menggantikan overflow bawaan agar sudut membulat terpotong rapi
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            color: const Color(0xFF1E3A8A),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Text(
                              "Informasi Matakuliah",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabelField("Kode Matakuliah"),
                                TextFormField(
                                  controller: _kodeController,
                                  decoration: _inputDecoration("Contoh: MK123"),
                                  validator: (v) => v == null || v.isEmpty
                                      ? "Kode wajib diisi"
                                      : null,
                                ),
                                const SizedBox(height: 14),
                                _buildLabelField("Matakuliah"),
                                TextFormField(
                                  controller: _namaController,
                                  decoration: _inputDecoration(
                                    "Nama mata kuliah",
                                  ),
                                  validator: (v) => v == null || v.isEmpty
                                      ? "Nama wajib diisi"
                                      : null,
                                ),
                                const SizedBox(height: 14),
                                _buildLabelField("SKS"),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [2, 3, 4].map((sksValue) {
                                    final isSelected = _selectedSks == sksValue;
                                    return Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          left: sksValue == 2 ? 0 : 6,
                                          right: sksValue == 4 ? 0 : 6,
                                        ),
                                        child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: isSelected
                                                ? Colors.transparent
                                                : Colors.white,
                                            side: BorderSide(
                                              color: isSelected
                                                  ? Colors.black87
                                                  : Colors.black26,
                                              width: isSelected ? 1.5 : 1,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                          ),
                                          onPressed: () => setState(
                                            () => _selectedSks = sksValue,
                                          ),
                                          child: Text(
                                            sksValue.toString(),
                                            style: GoogleFonts.poppins(
                                              color: Colors.black87,
                                              fontWeight: isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Tombol Aksi Simpan
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF22C55E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool isSuccess = await provider.editMataKuliah(
                              _kodeController.text,
                              _namaController.text,
                              _selectedSks,
                            );
                            if (context.mounted) {
                              if (isSuccess) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Data berhasil diperbaharui"),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Gagal memperbaharui data"),
                                  ),
                                );
                              }
                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.save,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Simpan",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          if (provider.isLoading)
            Container(
              color: Colors.black12,
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLabelField(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 13,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.black38),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.black26),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.black26),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.black87),
      ),
    );
  }
}
