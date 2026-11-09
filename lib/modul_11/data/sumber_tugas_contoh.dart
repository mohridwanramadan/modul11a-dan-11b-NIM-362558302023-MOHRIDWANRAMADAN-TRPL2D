import '../domain/tugas_performa.dart';

const daftarMataKuliahContoh = <String>[
  'Pemrograman Mobile',
  'Basis Data',
  'Jaringan Komputer',
  'Rekayasa Perangkat Lunak',
  'Sistem Operasi',
  'Kecerdasan Buatan',
  'Pemrograman Web',
  'Analisis dan Perancangan Sistem',
];

List<TugasPerforma> buatTugasContoh() {
  return List<TugasPerforma>.unmodifiable(
    List<TugasPerforma>.generate(1000, (index) {
      final nomor = index + 1;
      // Geser pola pada tiap putaran agar status selesai tersebar merata.
      final putaran = index ~/ daftarMataKuliahContoh.length;
      return TugasPerforma(
        nomor: nomor,
        mataKuliah:
            daftarMataKuliahContoh[index % daftarMataKuliahContoh.length],
        status: (nomor + putaran) % 4 == 0
            ? StatusTugas.selesai
            : StatusTugas.aktif,
      );
    }),
  );
}
