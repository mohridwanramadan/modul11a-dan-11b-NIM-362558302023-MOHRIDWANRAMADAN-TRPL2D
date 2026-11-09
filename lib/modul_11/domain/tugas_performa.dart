enum StatusTugas { aktif, selesai }

class TugasPerforma {
  factory TugasPerforma({
    required int nomor,
    required String mataKuliah,
    required StatusTugas status,
  }) {
    final judul = 'Tugas praktikum ${nomor.toString().padLeft(4, '0')}';
    return TugasPerforma._(nomor, mataKuliah, status, judul);
  }

  TugasPerforma._(this.nomor, this.mataKuliah, this.status, this.judul)
    : kunciPencarian = '$judul $mataKuliah'.toLowerCase();

  final int nomor;
  final String mataKuliah;
  final StatusTugas status;
  final String judul;
  final String kunciPencarian;
}
