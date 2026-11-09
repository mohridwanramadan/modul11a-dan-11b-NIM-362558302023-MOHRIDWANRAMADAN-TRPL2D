import 'package:flutter/foundation.dart';

import '../../../modul_11/domain/tugas_performa.dart';
import '../data/sumber_tugas_berhalaman.dart';

class PengendaliHalaman extends ChangeNotifier {
  PengendaliHalaman(this._sumber);

  final SumberTugasBerhalaman _sumber;
  List<TugasPerforma> _tugas = const [];
  int _halamanBerikutnya = 1;
  bool _memuat = false;
  bool _adaBerikutnya = true;
  bool _ditutup = false;
  String? _galat;

  List<TugasPerforma> get tugas => _tugas;
  bool get memuat => _memuat;
  bool get adaBerikutnya => _adaBerikutnya;
  String? get galat => _galat;

  Future<void> muatBerikutnya() async {
    if (_ditutup || _memuat || !_adaBerikutnya) return;
    _memuat = true;
    _galat = null;
    notifyListeners();

    try {
      final halaman = await _sumber.ambilHalaman(
        halaman: _halamanBerikutnya,
        ukuran: 50,
      );
      if (_ditutup) return;
      _tugas = List.unmodifiable([..._tugas, ...halaman.tugas]);
      _adaBerikutnya = halaman.adaBerikutnya;
      _halamanBerikutnya++;
    } catch (_) {
      if (!_ditutup) _galat = 'Gagal memuat halaman $_halamanBerikutnya.';
    } finally {
      _memuat = false;
      if (!_ditutup) notifyListeners();
    }
  }

  @override
  void dispose() {
    _ditutup = true;
    super.dispose();
  }
}
