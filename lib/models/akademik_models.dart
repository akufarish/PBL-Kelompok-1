class Kurikulum {
  final String id; // Diubah dari int ke String sesuai UUID dari API
  final String nama;

  Kurikulum({required this.id, required this.nama});

  factory Kurikulum.fromJson(Map<String, dynamic> json) {
    return Kurikulum(
      id: json['id'] ?? '', // Default berupa String kosong jika null
      nama: json['name'] ?? '', // Diubah dari 'nama' menjadi 'name' sesuai API
    );
  }
}

class Kelas {
  final String id;
  final String namaKelas;

  Kelas({required this.id, required this.namaKelas});

  factory Kelas.fromJson(Map<String, dynamic> json) {
    return Kelas(id: json['id'] ?? 0, namaKelas: json['nama_kelas'] ?? '');
  }
}

class Khs {
  final int id;
  final String semester;

  Khs({required this.id, required this.semester});

  factory Khs.fromJson(Map<String, dynamic> json) {
    return Khs(id: json['id'] ?? 0, semester: json['semester'] ?? '');
  }
}

class Nilai {
  final int id;
  final double angka;

  Nilai({required this.id, required this.angka});

  factory Nilai.fromJson(Map<String, dynamic> json) {
    return Nilai(id: json['id'] ?? 0, angka: (json['angka'] ?? 0).toDouble());
  }
}

class TahunAkademik {
  final int id;
  final String tipeSemester;
  final String tahunAwal;
  final String tahunAkhir;
  final String status;

  TahunAkademik({
    required this.id,
    required this.tipeSemester,
    required this.tahunAwal,
    required this.tahunAkhir,
    required this.status,
  });

  factory TahunAkademik.fromJson(Map<String, dynamic> json) {
    return TahunAkademik(
      id: json["id"],
      tipeSemester:
          json["tipee_semester"], // Tetap mempertahankan key typo dari API Anda
      tahunAwal: json["tahun_awal"],
      tahunAkhir: json["tahun_akhir"],
      status: json["status"],
    );
  }
}
