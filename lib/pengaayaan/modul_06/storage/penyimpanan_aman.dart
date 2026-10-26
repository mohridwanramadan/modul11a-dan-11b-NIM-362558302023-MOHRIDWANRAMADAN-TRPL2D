abstract class PenyimpananAman {
  Future<void> tulis(String kunci, String nilai);
  Future<String?> baca(String kunci);
  Future<void> hapus(String kunci);

  // Untuk demo "intip" isi penyimpanan (hanya berfungsi di beberapa platform)
  Future<String?> bacaMentah(String kunci);
}