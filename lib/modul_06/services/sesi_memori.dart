import '../models/sesi_pengguna.dart';

class SesiMemori {
  SesiPengguna? _sesi;

  SesiPengguna? baca() => _sesi;

  Future<void> simpan(SesiPengguna sesi) async {
    _sesi = sesi;
  }

  Future<void> hapus() async {
    _sesi = null;
  }
}