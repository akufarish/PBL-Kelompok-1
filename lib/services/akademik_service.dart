import 'package:admin_pegawai/models/akademik_models.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'api_client.dart';

class AkademikService {
  final Dio _dio = ApiClient().dio;

  Future<List<TahunAkademik>> fetchTahunAkademik() async {
    try {
      final response = await _dio.get("/api/tahun-akademik");

      if (response.statusCode == 200 && response.data["success"] == true) {
        final List<dynamic> data = response.data["data"];
        return data.map((item) => TahunAkademik.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint("Error fetching tahun akademik: $e");
      return [];
    }
  }

  Future<List<Kurikulum>> fetchKurikulum() async {
    try {
      final response = await _dio.get("/api/kurikulum");
      if (response.statusCode == 200 && response.data["success"] == true) {
        // PERBAIKAN: Tambahkan ["items"] karena list data berada di dalam key tersebut
        final List<dynamic> data = response.data["data"]["items"];
        return data.map((item) => Kurikulum.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint("Error fetching kurikulum: $e");
      return [];
    }
  }

  Future<List<Kelas>> fetchKelas() async {
    try {
      final response = await _dio.get("/api/kelas");
      if (response.statusCode == 200 && response.data["success"] == true) {
        final List<dynamic> data = response.data["data"];
        return data.map((item) => Kelas.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint("Error fetching kelas: $e");
      return [];
    }
  }

  Future<List<Khs>> fetchKhs() async {
    try {
      final response = await _dio.get("/api/khs");
      if (response.statusCode == 200 && response.data["success"] == true) {
        final List<dynamic> data = response.data["data"];
        return data.map((item) => Khs.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint("Error fetching khs: $e");
      return [];
    }
  }

  Future<List<Nilai>> fetchNilai() async {
    try {
      final response = await _dio.get("/api/nilai");
      if (response.statusCode == 200 && response.data["success"] == true) {
        final List<dynamic> data = response.data["data"];
        return data.map((item) => Nilai.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint("Error fetching nilai: $e");
      return [];
    }
  }
}
