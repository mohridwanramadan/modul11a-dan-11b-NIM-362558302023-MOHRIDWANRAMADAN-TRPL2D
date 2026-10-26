import 'dart:convert';
import '../../../modul_06/models/sesi_pengguna.dart';
import '../storage/penyimpanan_aman.dart';
import 'sesi_repository.dart';

class AmanSesiRepository implements SesiRepository {
  static const String _kunci = 'modul_06_sesi_aman';
  final PenyimpananAman _storage;

  AmanSesiRepository(this._storage);

  @override
  String get nama => 'Secure Storage';
  @override
  bool get bertahanSetelahRestart => true;

  @override
  Future<SesiPengguna?> baca() async {
    final jsonStr = await _storage.baca(_kunci);
    if (jsonStr == null) return null;
    try {
      return SesiPengguna.fromJson(jsonDecode(jsonStr));
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> simpan(SesiPengguna sesi) async {
    await _storage.tulis(_kunci, jsonEncode(sesi.toJson()));
  }

  @override
  Future<void> hapus() async {
    await _storage.hapus(_kunci);
  }

  @override
  Future<String?> intipMentah() async {
    return _storage.bacaMentah(_kunci); // Akan mengembalikan null (aman)
  }
}