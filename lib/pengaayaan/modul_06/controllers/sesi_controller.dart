import 'package:flutter/foundation.dart';
import '../../../modul_06/models/sesi_pengguna.dart';
import '../../../modul_06/services/auth_api.dart';
import '../repositories/sesi_repository.dart';

enum StatusSesi { memeriksa, keluar, memproses, masuk, gagal, kedaluwarsa }

class SesiController extends ChangeNotifier {
  final AuthApi api;
  final SesiRepository repository;
  final DateTime Function() jam;

  StatusSesi _status = StatusSesi.memeriksa;
  SesiPengguna? _sesi;
  String? _pesanError;

  // ✅ LATIHAN 5: State untuk navigasi
  bool _diHalamanProfil = false;
  bool get diHalamanProfil => _diHalamanProfil;

  SesiController({
    required this.api,
    required this.repository,
    this.jam = DateTime.now,
  });

  StatusSesi get status => _status;
  SesiPengguna? get sesi => _sesi;
  String? get pesanError => _pesanError;
  SesiRepository get repo => repository;

  // ✅ LATIHAN 5: Fungsi navigasi
  void bukaProfil() {
    _diHalamanProfil = true;
    notifyListeners();
  }

  void tutupProfil() {
    _diHalamanProfil = false;
    notifyListeners();
  }

  Future<void> pulihkan() async {
    _ubahStatus(StatusSesi.memeriksa);
    final tersimpan = await repository.baca();

    if (tersimpan == null) {
      _ubahStatus(StatusSesi.keluar);
      return;
    }

    if (tersimpan.sudahKedaluwarsa(jam())) {
      await repository.hapus();
      _sesi = null;
      _ubahStatus(StatusSesi.kedaluwarsa, pesan: 'Sesi Anda sudah berakhir.');
      return;
    }

    _sesi = tersimpan;
    _ubahStatus(StatusSesi.masuk);
  }

  Future<void> login(String email, String sandi) async {
    if (_status == StatusSesi.memproses) return;
    _ubahStatus(StatusSesi.memproses, pesan: null);

    try {
      final hasil = await api.masuk(email: email, sandi: sandi);
      await repository.simpan(hasil);
      _sesi = hasil;
      _diHalamanProfil = false; // Pastikan mulai dari beranda
      _ubahStatus(StatusSesi.masuk);
    } on AuthException catch (e) {
      _ubahStatus(StatusSesi.gagal, pesan: e.pesan);
    } catch (e) {
      _ubahStatus(StatusSesi.gagal, pesan: 'Terjadi kesalahan tak terduga.');
    }
  }

  Future<void> logout() async {
    await repository.hapus();
    _sesi = null;
    _diHalamanProfil = false;
    _ubahStatus(StatusSesi.keluar, pesan: null);
  }

  void _ubahStatus(StatusSesi baru, {String? pesan}) {
    _status = baru;
    if (pesan != null) _pesanError = pesan;
    notifyListeners();
  }
}