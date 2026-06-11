import 'package:admin_pegawai/models/akademik_models.dart';
import 'package:admin_pegawai/services/akademik_service.dart';
import 'package:flutter/material.dart';

class AkademikProvider with ChangeNotifier {
  final AkademikService _akademikService = AkademikService();

  bool _isLoading = false;
  List<TahunAkademik> _listTahunAkademik = [];
  List<Kurikulum> _listKurikulum = [];
  List<Kelas> _listKelas = [];
  List<Khs> _listKhs = [];
  List<Nilai> _listNilai = [];

  // Getters
  bool get isLoading => _isLoading;
  List<TahunAkademik> get listTahunAkademik => _listTahunAkademik;
  List<Kurikulum> get listKurikulum => _listKurikulum;
  List<Kelas> get listKelas => _listKelas;
  List<Khs> get listKhs => _listKhs;
  List<Nilai> get listNilai => _listNilai;

  Future<void> fetchAkademikData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final responses = await Future.wait([
        _akademikService.fetchTahunAkademik(),
        _akademikService.fetchKurikulum(),
        _akademikService.fetchKelas(),
        _akademikService.fetchKhs(),
        _akademikService.fetchNilai(),
      ]);

      _listTahunAkademik = responses[0] as List<TahunAkademik>;
      _listKurikulum = responses[1] as List<Kurikulum>;
      _listKelas = responses[2] as List<Kelas>;
      _listKhs = responses[3] as List<Khs>;
      _listNilai = responses[4] as List<Nilai>;
    } catch (e) {
      debugPrint("Error fetching akademik data: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
