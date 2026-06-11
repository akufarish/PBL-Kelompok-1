class Kurikulum {
  final String id;
  final String nama;

  Kurikulum({required this.id, required this.nama});

  factory Kurikulum.fromJson(Map<String, dynamic> json) {
    return Kurikulum(
      id: json['id'] ?? '',
      nama: json['name'] ?? json['nama'] ?? '',
    );
  }
}

class Prodi {
  final String id;
  final String nama;

  Prodi({required this.id, required this.nama});

  factory Prodi.fromJson(Map<String, dynamic> json) {
    return Prodi(
      id: json['id'] ?? '',
      nama: json['name'] ?? json['nama'] ?? '',
    );
  }
}

class Kelas {
  final String id;
  final String nama;
  final String tahunAkademik;

  Kelas({required this.id, required this.nama, required this.tahunAkademik});

  factory Kelas.fromJson(Map<String, dynamic> json) {
    return Kelas(
      id: json['id'] ?? '',
      nama: json['nama'] ?? json['nama_kelas'] ?? '',
      tahunAkademik: json['tahun_akademik'] ?? '2024/2025 Genap',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nama': nama, 'tahun_akademik': tahunAkademik};
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

class MataKuliah {
  final String id;
  final String kode;
  final String name;
  final int sks;

  MataKuliah({
    required this.id,
    required this.kode,
    required this.name,
    required this.sks,
  });

  factory MataKuliah.fromJson(Map<String, dynamic> json) {
    return MataKuliah(
      id: json['id'] ?? '',
      kode: json['kode'] ?? '',
      name: json['name'] ?? '',
      sks: json['sks'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'kode': kode, 'name': name, 'sks': sks};
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
      id: json["id"] ?? 0,
      tipeSemester: json["tipee_semester"] ?? json["tipe_semester"] ?? '',
      tahunAwal: json["tahun_awal"] ?? '',
      tahunAkhir: json["tahun_akhir"] ?? '',
      status: json["status"] ?? '',
    );
  }
}
