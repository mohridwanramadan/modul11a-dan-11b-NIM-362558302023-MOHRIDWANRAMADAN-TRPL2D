import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../modul_06/models/sesi_pengguna.dart';
import 'sesi_repository.dart';

class PrefsSesiRepository implements SesiRepository {
  static const String _kunci = 'modul_06_sesi_prefs';

  @override
  String get nama => 'SharedPreferences';
  @override
  bool get bertahanSetelahRestart => true;

  @override
  Future<SesiPengguna?> baca() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_kunci);
    if (jsonStr == null) return null;
    try {
      return SesiPengguna.fromJson(jsonDecode(jsonStr));
    } catch (_) {
      return null; // Data rusak
    }
  }

  @override
  Future<void> simpan(SesiPengguna sesi) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kunci, jsonEncode(sesi.toJson()));
  }

  @override
  Future<void> hapus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kunci);
  }

  @override
  Future<String?> intipMentah() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kunci); // Akan mengembalikan JSON token asli!
  }
}