import 'tugas_performa.dart';

class KriteriaFilter {
  const KriteriaFilter({this.kueri = '', this.status, this.mataKuliah});

  final String kueri;
  final StatusTugas? status;
  final String? mataKuliah;

  KriteriaFilter salinDengan({
    String? kueri,
    StatusTugas? status,
    bool hapusStatus = false,
    String? mataKuliah,
    bool hapusMataKuliah = false,
  }) {
    return KriteriaFilter(
      kueri: kueri ?? this.kueri,
      status: hapusStatus ? null : status ?? this.status,
      mataKuliah: hapusMataKuliah ? null : mataKuliah ?? this.mataKuliah,
    );
  }
}

List<TugasPerforma> saringTugas(
  List<TugasPerforma> semuaTugas,
  KriteriaFilter kriteria,
) {
  final kueri = kriteria.kueri.trim().toLowerCase();
  return semuaTugas
      .where((tugas) {
        return (kriteria.status == null || tugas.status == kriteria.status) &&
            (kriteria.mataKuliah == null ||
                tugas.mataKuliah == kriteria.mataKuliah) &&
            tugas.kunciPencarian.contains(kueri);
      })
      .toList(growable: false);
}
