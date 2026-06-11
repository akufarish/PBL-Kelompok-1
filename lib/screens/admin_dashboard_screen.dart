import 'package:admin_pegawai/models/user_models.dart';
import 'package:admin_pegawai/providers/auth_provider.dart';
import 'package:admin_pegawai/providers/user_provider.dart';
import 'package:admin_pegawai/providers/akademik_provider.dart';
import 'package:admin_pegawai/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
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
  final PageController _academicPageController = PageController();
  int _currentAcademicPage = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<UserProvider>().profile();
      context.read<UserProvider>().fetchDashboardUserData();
      context.read<AkademikProvider>().fetchAkademikData();
    });
  }

  @override
  void dispose() {
    _academicPageController.dispose();
    super.dispose();
  }

  void doLogout() async {
    bool isSuccess = await context.read<AuthProvider>().logout();

    if (!mounted) return;

    if (isSuccess) {
      context.read<UserProvider>().clearUserData();
      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan saat logout")),
      );
    }
  }

  String _formatDisplayDate(String dateStr) {
    try {
      DateTime dateTime = DateTime.parse(dateStr);
      List<String> months = [
        'JAN',
        'FEB',
        'MAR',
        'APR',
        'MEI',
        'JUN',
        'JUL',
        'AGU',
        'SEP',
        'OKT',
        'NOV',
        'DES',
      ];
      return "${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}";
    } catch (_) {
      return dateStr;
    }
  }

  String _getTahunAkademikLabel(int id) {
    String idStr = id.toString();
    if (idStr.length >= 4) {
      int startYear = int.parse(idStr.substring(0, 4));
      return "$startYear-${startYear + 1}";
    }
    return "$id";
  }

  Widget _buildAcademicYearItem(dynamic item) {
    final String label = _getTahunAkademikLabel(item.id);
    final String tipe = item.tipeSemester.toUpperCase();
    final String mulai = _formatDisplayDate(item.tahunAwal);
    final String selesai = _formatDisplayDate(item.tahunAkhir);

    return _buildAcademicYearCard(
      "Tahun Akademik $label ($tipe)",
      mulai,
      selesai,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final akademikProvider = context.watch<AkademikProvider>();

    final UserResponse? user = userProvider.data;
    final int academicPageCount =
        (akademikProvider.listTahunAkademik.length / 2).ceil();

    final bool isLoadingCombined =
        userProvider.isLoading || akademikProvider.isLoading;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            Image.asset(
              'assets/logo/logo.png',
              height: 50,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            Text(
              'SABAR',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black87),
            onPressed: () => doLogout(),
          ),
        ],
      ),
      body: isLoadingCombined
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await context.read<UserProvider>().profile();
                await Future.wait([
                  context.read<UserProvider>().fetchDashboardUserData(),
                  context.read<AkademikProvider>().fetchAkademikData(),
                ]);
              },
              color: AppColors.primaryColor,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        "Selamat Datang, ${user?.name ?? 'Admin akademik'}",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "Lagi mau ngapain nih?",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: CardCount(
                              icon: Icons.business_center,
                              label: "Total Pegawai",
                              total: userProvider.totalUser,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CardCount(
                              icon: Icons.co_present,
                              label: "Total Dosen",
                              total: userProvider.totalDosen,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: const CardCount(
                              icon: Icons.people,
                              label: "Total Mahasiswa",
                              total: 1024,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                      const SizedBox(height: 28),
                      Text(
                        "Fitur Utama",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.95,
                        children: [
                          _buildMenuIcon("Kurikulum", Icons.menu_book, () {
                            Navigator.pushNamed(context, "/kurikulum");
                          }),
                          _buildMenuIcon(
                            "Kelas",
                            Icons.meeting_room_outlined,
                            () {
                              Navigator.pushNamed(context, "/kelas");
                            },
                          ),
                          _buildMenuIcon("KHS", Icons.assignment_outlined, () {
                            // Tambahkan rute jika sudah ada
                          }),
                          _buildMenuIcon("Nilai", Icons.edit_note_outlined, () {
                            // Tambahkan rute jika sudah ada
                          }),
                          _buildMenuIcon("Dosen", Icons.co_present, () {
                            // Tambahkan rute jika sudah ada
                          }),
                          _buildMenuIcon(
                            "Presensi",
                            Icons.analytics_outlined,
                            () {
                              // Tambahkan rute jika sudah ada
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Data Tahun Akademik",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: "Tahun Akademik",
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black54,
                            ),
                            style: GoogleFonts.poppins(
                              color: Colors.black87,
                              fontSize: 13,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: "Tahun Akademik",
                                child: Text("Tahun Akademik"),
                              ),
                            ],
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      if (akademikProvider.listTahunAkademik.isNotEmpty) ...[
                        SizedBox(
                          height: 250,
                          child: PageView.builder(
                            controller: _academicPageController,
                            itemCount: academicPageCount,
                            onPageChanged: (index) {
                              setState(() {
                                _currentAcademicPage = index;
                              });
                            },
                            itemBuilder: (context, pageIndex) {
                              final int firstIndex = pageIndex * 2;
                              final int secondIndex = firstIndex + 1;

                              return Column(
                                children: [
                                  if (firstIndex <
                                      akademikProvider.listTahunAkademik.length)
                                    _buildAcademicYearItem(
                                      akademikProvider
                                          .listTahunAkademik[firstIndex],
                                    ),
                                  if (secondIndex <
                                      akademikProvider
                                          .listTahunAkademik
                                          .length) ...[
                                    const SizedBox(height: 12),
                                    _buildAcademicYearItem(
                                      akademikProvider
                                          .listTahunAkademik[secondIndex],
                                    ),
                                  ],
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(academicPageCount, (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentAcademicPage == index
                                    ? Colors.black.withOpacity(0.4)
                                    : Colors.black.withOpacity(0.08),
                              ),
                            );
                          }),
                        ),
                      ],
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildMenuIcon(String label, IconData icon, VoidCallback onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          hoverColor: Colors.black.withOpacity(0.02),
          splashColor: Colors.black.withOpacity(0.04),
          highlightColor: Colors.black.withOpacity(0.01),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 24),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAcademicYearCard(String title, String start, String end) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tahun Mulai",
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.black54),
              ),
              Text(
                ": $start",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tahun Selesai",
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.black54),
              ),
              Text(
                ": $end",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
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
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondaryColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 22),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            total.toString(),
            style: GoogleFonts.poppins(
              color: AppColors.primaryColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
