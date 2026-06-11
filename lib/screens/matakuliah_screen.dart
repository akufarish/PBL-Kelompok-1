import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:admin_pegawai/providers/akademik_provider.dart';
import 'package:admin_pegawai/utils/app_colors.dart';

class MatakuliahListScreen extends StatefulWidget {
  const MatakuliahListScreen({super.key});

  @override
  State<MatakuliahListScreen> createState() => _MatakuliahListScreenState();
}

class _MatakuliahListScreenState extends State<MatakuliahListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatTitle(String text) {
    if (text.isEmpty) return text;
    return text
        .replaceAll('-', ' ')
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          if (word.toLowerCase() == "iot") return "IoT";
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AkademikProvider>();
    final isSelectingKurikulum = provider.selectedJurikulum == null;

    // Filter data berdasarkan search bar input
    final filteredKurikulum = provider.listKurikulum.where((k) {
      return k.nama.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    final filteredMatakuliah = provider.listMataKuliah.where((mk) {
      return mk.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          mk.kode.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs & Tombol Kembali
            GestureDetector(
              onTap: () {
                if (isSelectingKurikulum) {
                  Navigator.pop(context);
                } else {
                  provider.selectedJurikulum = null;
                  provider.notifyListeners();
                }
              },
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
              "Akademik > Matakuliah",
              style: GoogleFonts.poppins(fontSize: 11, color: Colors.black45),
            ),
            Text(
              "Matakuliah",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              "Kumpulan matakuliah yang tersedia",
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 16),

            // Search Bar Component
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: InputDecoration(
                  hintText: "Cari...",
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black38,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.black38),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isSelectingKurikulum
                  ? "Pilih Kurikulum yang diinginkan"
                  : "Pilih matakuliah yang diinginkan",
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // List Render
            Expanded(
              child: provider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : isSelectingKurikulum
                  ? ListView.separated(
                      itemCount: filteredKurikulum.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final kurikulum = filteredKurikulum[index];
                        return _buildCardTile(
                          title: _formatTitle(kurikulum.nama),
                          subtitle: "8 Prodi",
                          onTap: () {
                            provider.selectedJurikulum = kurikulum;
                            _searchController.clear();
                            setState(() => _searchQuery = "");
                            provider.notifyListeners();
                          },
                        );
                      },
                    )
                  : ListView.separated(
                      itemCount: filteredMatakuliah.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final mk = filteredMatakuliah[index];
                        return _buildCardTile(
                          title: _formatTitle(mk.name),
                          subtitle: "${mk.sks} SKS",
                          onTap: () {
                            provider.selectedMataKuliah = mk;
                            Navigator.pushNamed(context, "/matakuliah-detail");
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardTile({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
