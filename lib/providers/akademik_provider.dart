import 'package:admin_pegawai/models/akademik_models.dart';
import 'package:admin_pegawai/services/akademik_service.dart';
import 'package:flutter/material.dart';

class AkademikProvider with ChangeNotifier {
  final AkademikService _akademikService = AkademikService();

  bool _isLoading = false;
  List<TahunAkademik> _listTahunAkademik = [];
  List<Kurikulum> _listKurikulum = [];
  List<Prodi> _listProdi = [];
  List<Kelas> _listKelas = [];
  List<Khs> _listKhs = [];
  List<Nilai> _listNilai = [];
  List<MataKuliah> _listMataKuliah = [];

  Kurikulum? selectedJurikulum;
  Prodi? selectedProdi;
  Kelas? selectedKelas;
  MataKuliah? selectedMataKuliah;

  bool get isLoading => _isLoading;
  List<TahunAkademik> get listTahunAkademik => _listTahunAkademik;
  List<Kurikulum> get listKurikulum => _listKurikulum;
  List<Prodi> get listProdi => _listProdi;
  List<Kelas> get listKelas => _listKelas;
  List<Khs> get listKhs => _listKhs;
  List<Nilai> get listNilai => _listNilai;
  List<MataKuliah> get listMataKuliah => _listMataKuliah;

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
        _akademikService.fetchMataKuliah(),
        _akademikService.fetchProdi(),
      ]);

      _listTahunAkademik = responses[0] as List<TahunAkademik>;
      _listKurikulum = responses[1] as List<Kurikulum>;
      _listKelas = responses[2] as List<Kelas>;
      _listKhs = responses[3] as List<Khs>;
      _listNilai = responses[4] as List<Nilai>;
      _listMataKuliah = responses[5] as List<MataKuliah>;
      _listProdi = responses[6] as List<Prodi>;
    } catch (e) {
      debugPrint("Error fetching akademik data: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> editKelas(String nama, String tahunAkademik) async {
    if (selectedKelas == null) return false;
    _isLoading = true;
    notifyListeners();

    final updatedData = Kelas(
      id: selectedKelas!.id,
      nama: nama,
      tahunAkademik: tahunAkademik,
    );

    bool isSuccess = await _akademikService.updateKelas(updatedData);
    if (isSuccess) {
      selectedKelas = updatedData;
      int idx = _listKelas.indexWhere(
        (element) => element.id == updatedData.id,
      );
      if (idx != -1) _listKelas[idx] = updatedData;
    }

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }

  Future<bool> removeKelas() async {
    if (selectedKelas == null) return false;
    _isLoading = true;
    notifyListeners();

    bool isSuccess = await _akademikService.deleteKelas(selectedKelas!.id);
    if (isSuccess) {
      _listKelas.removeWhere((element) => element.id == selectedKelas!.id);
      selectedKelas = null;
    }

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }

  Future<bool> editMataKuliah(String kode, String name, int sks) async {
    if (selectedMataKuliah == null) return false;
    _isLoading = true;
    notifyListeners();

    final updatedData = MataKuliah(
      id: selectedMataKuliah!.id,
      kode: kode,
      name: name,
      sks: sks,
    );

    bool isSuccess = await _akademikService.updateMataKuliah(updatedData);
    if (isSuccess) {
      selectedMataKuliah = updatedData;
      int idx = _listMataKuliah.indexWhere(
        (element) => element.id == updatedData.id,
      );
      if (idx != -1) _listMataKuliah[idx] = updatedData;
    }

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }

  Future<bool> removeMataKuliah() async {
    if (selectedMataKuliah == null) return false;
    _isLoading = true;
    notifyListeners();

    bool isSuccess = await _akademikService.deleteMataKuliah(
      selectedMataKuliah!.id,
    );
    if (isSuccess) {
      _listMataKuliah.removeWhere(
        (element) => element.id == selectedMataKuliah!.id,
      );
      selectedMataKuliah = null;
    }

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }
}
