import '../../../modul_06/models/sesi_pengguna.dart';

abstract class SesiRepository {
  String get nama;
  bool get bertahanSetelahRestart;

  Future<SesiPengguna?> baca();
  Future<void> simpan(SesiPengguna sesi);
  Future<void> hapus();
  Future<String?> intipMentah(); // Untuk Papan Diagnostik
}