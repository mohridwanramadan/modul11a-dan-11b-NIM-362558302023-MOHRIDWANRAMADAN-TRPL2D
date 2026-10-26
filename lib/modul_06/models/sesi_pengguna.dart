class SesiPengguna {
  final String token;
  final String email;
  final String nama;
  final String peran;
  final String masukPada;
  final String kedaluwarsaPada;

  const SesiPengguna({
    required this.token,
    required this.email,
    required this.nama,
    required this.peran,
    required this.masukPada,
    required this.kedaluwarsaPada,
  });

  factory SesiPengguna.fromJson(Map<String, dynamic> json) {
    return SesiPengguna(
      token: json['token'] as String? ?? '',
      email: json['email'] as String? ?? 'tanpa-email',
      nama: json['nama'] as String? ?? 'Pengguna',
      peran: json['peran'] as String? ?? 'mahasiswa',
      masukPada: json['masukPada'] as String? ?? '1970-01-01T00:00:00.000',
      kedaluwarsaPada: json['kedaluwarsaPada'] as String? ?? '1970-01-01T00:00:00.000',
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'token': token,
    'email': email,
    'nama': nama,
    'peran': peran,
    'masukPada': masukPada,
    'kedaluwarsaPada': kedaluwarsaPada,
  };

  Duration sisaWaktu(DateTime sekarang) {
    final DateTime? batas = DateTime.tryParse(kedaluwarsaPada);
    if (batas == null) return Duration.zero;
    final Duration sisa = batas.difference(sekarang);
    return sisa.isNegative ? Duration.zero : sisa;
  }

  bool sudahKedaluwarsa(DateTime sekarang) {
    final DateTime? batas = DateTime.tryParse(kedaluwarsaPada);
    if (batas == null) return true;
    return !sekarang.isBefore(batas);
  }

  static String labelPeran(String peran) {
    switch (peran) {
      case 'dosen':
        return 'Dosen';
      case 'mahasiswa':
        return 'Mahasiswa';
      default:
        return 'Pengguna';
    }
  }
}