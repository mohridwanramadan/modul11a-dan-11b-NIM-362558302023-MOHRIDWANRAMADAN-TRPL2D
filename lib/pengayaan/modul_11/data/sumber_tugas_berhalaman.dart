import '../../../modul_11/data/sumber_tugas_contoh.dart';
import '../../../modul_11/domain/tugas_performa.dart';

typedef HalamanTugas = ({List<TugasPerforma> tugas, bool adaBerikutnya});

abstract class SumberTugasBerhalaman {
  Future<HalamanTugas> ambilHalaman({
    required int halaman,
    required int ukuran,
  });
}

class SumberTugasSimulasi implements SumberTugasBerhalaman {
  SumberTugasSimulasi({
    this.jeda = const Duration(milliseconds: 350),
    this.halamanGagalSekali = 3,
  });

  final Duration jeda;
  final int? halamanGagalSekali;
  final List<TugasPerforma> _tugas = buatTugasContoh();
  bool _sudahGagal = false;

  @override
  Future<HalamanTugas> ambilHalaman({
    required int halaman,
    required int ukuran,
  }) async {
    RangeError.checkNotNegative(halaman - 1, 'halaman - 1');
    RangeError.checkNotNegative(ukuran - 1, 'ukuran - 1');
    if (jeda > Duration.zero) await Future<void>.delayed(jeda);
    if (halaman == halamanGagalSekali && !_sudahGagal) {
      _sudahGagal = true;
      throw StateError('Gagal memuat halaman $halaman.');
    }

    final akhir = halaman * ukuran;
    return (
      tugas: _tugas.skip(akhir - ukuran).take(ukuran).toList(growable: false),
      adaBerikutnya: akhir < _tugas.length,
    );
  }
}
