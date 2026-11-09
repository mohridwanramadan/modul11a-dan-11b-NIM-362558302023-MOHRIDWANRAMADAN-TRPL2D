Laporan Praktikum Modul 11A dan 11B

Moh Ridwan Ramadan
NIM 362558302023
Kelas dan program studi 2D / Sarjana Terapan TRPL
Mata kuliah Pemrograman Perangkat Bergerak, Semester 3

Pendahuluan
Praktikum Modul 11 membahas optimasi performa aplikasi Flutter melalui aplikasi Tugas Kuliah. Modul 11A berfokus pada cara menampilkan daftar panjang dan menyaring tugas. Modul 11B berfokus pada cara memuat data secara bertahap dengan paginasi.
Modul 11A — Daftar Tugas dan Penyaringan
Aplikasi menampilkan 1.000 tugas contoh, dengan 250 tugas berstatus selesai. Daftar menggunakan ListView.builder agar kartu dibuat sesuai kebutuhan saat layar ditampilkan atau daftar digulir.

Pengguna dapat mencari tugas berdasarkan judul atau nama mata kuliah dan menyaringnya berdasarkan status. Filter mata kuliah tersedia melalui ikon di kanan atas layar. Pencarian, status, dan mata kuliah dapat digunakan bersamaan. Sebagai contoh, memilih mata kuliah Basis Data menampilkan 125 tugas. Jika status Selesai juga dipilih, jumlahnya menjadi 31 tugas.
Modul 11B — Paginasi
Aplikasi meminta 50 tugas dalam setiap halaman dari sumber data simulasi lokal. Ketika pengguna mendekati akhir daftar, aplikasi meminta halaman berikutnya dan menampilkan indikator pemuatan. Permintaan tambahan diabaikan selama pemuatan masih berlangsung.

Pada percobaan pertama, halaman ketiga sengaja gagal dimuat. Tugas yang sudah tampil tetap tersedia. Pengguna dapat menekan Coba lagi untuk memuat ulang halaman yang sama. Setelah halaman itu berhasil dimuat, daftar dilanjutkan dari tugas nomor 0101. Ketika seluruh data habis, aplikasi menampilkan pesan bahwa semua 1.000 tugas telah dimuat.
Pengujian
Pengujian Modul 11A mencakup pencarian, penyaringan, keadaan tanpa hasil, dan kemampuan menggulir daftar hingga tugas terakhir. Tes latihan mahasiswa juga memeriksa apakah pilihan mata kuliah dan status menghasilkan jumlah tugas yang sesuai. Pengujian Modul 11B mencakup pemuatan bertahap, percobaan ulang setelah gagal, pencegahan permintaan ganda, dan penghentian pemuatan setelah data habis.
Kesimpulan
ListView.builder mengatur kapan widget kartu dibuat, sedangkan paginasi mengatur kapan halaman data berikutnya diminta. Keduanya bekerja bersama pada Modul 11B. Aplikasi mengambil data per halaman dan membuat kartu sesuai kebutuhan ketika pengguna melihat atau menggulir daftar.
