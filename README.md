# Laporan Praktikum Modul 04

- **Nama**: Moh Ridwan Ramadan
- **NIM**: 362558302023
- **Kelas / Prodi**: 2D / Sarjana Terapan TRPL
- **Mata Kuliah**: Pemrograman Perangkat Bergerak (Semester 3)

---

# Modul 04 — Portal Pengumuman TRPL (Fase A)

Aplikasi Flutter sederhana untuk menampilkan daftar pengumuman dari endpoint
REST menggunakan `package:http`. Aplikasi ini adalah hasil praktikum Modul 04
Fase A — Future & REST API Dasar.

## Fitur

- Mengambil data dari `https://jsonplaceholder.typicode.com/posts?_limit=10`
  menggunakan `package:http` dengan `baseUrl` dan `timeout` 10 detik yang jelas.
- Empat keadaan UI dengan tampilan masing-masing:
  **memuat**, **gagal**, **kosong**, dan **berhasil**.
- Keadaan gagal membedakan tiga jenis kegagalan:
  - **Timeout** — koneksi ke server melebihi 10 detik.
  - **Koneksi gagal** — tidak dapat menghubungi server.
  - **Status ≠ 200** — server merespons dengan status error (mis. 500).
- Tombol **Coba Lagi** pada keadaan gagal dan **pull-to-refresh** pada daftar,
  keduanya benar-benar memuat ulang data dari server.
- Filter kategori (`Semua`, `Akademik`, `Beasiswa`, `Kegiatan`, `Prestasi`)
  yang **tidak** mengirim permintaan baru — penyaringan dilakukan di memori.
- Menekan kartu membuka layar detail via `Navigator.push`,
  kembali dengan `Navigator.pop` (tombol back AppBar).
- `http.Client` ditutup pada `dispose()` untuk mencegah kebocoran memori.

## Struktur Proyek

```
lib/modul_04/
├── modul_04_app.dart
├── models/
│   └── announcement.dart
├── services/
│   └── announcement_api.dart
├── widgets/
│   └── announcement_card.dart
└── screens/
    ├── announcement_list_screen.dart
    └── announcement_detail_screen.dart

test/
└── modul_04_test.dart
```

## Cara Menjalankan

### Prasyarat

- Flutter SDK (channel stable)
- Dart SDK ≥ 3.11.5
- Koneksi internet (untuk mode online)

### Instalasi

```bash
flutter pub get
```

### Mode Simulasi (tanpa internet)

Menampilkan data contoh dari `Announcement.getSampleAnnouncements()`:

```bash
flutter run -t lib/modul_04/modul_04_app.dart --dart-define=SIMULASI=true
```

### Mode Online (butuh internet)

Mengambil data dari `jsonplaceholder.typicode.com`:

```bash
flutter run -t lib/modul_04/modul_04_app.dart
```

## Pengujian

### Analisis Statis

```bash
flutter analyze
```

Target: **No issues found!**

### Unit & Widget Test

```bash
flutter test test/modul_04_test.dart
```

Cakupan tes:

- `Announcement.fromJson` — nilai cadangan setiap field, konversi `body` → `content`, konversi `id` string → int.
- `AnnouncementApi` — sukses (respons 200), timeout, koneksi gagal, status ≠ 200, respons bukan JSON.
- `AnnouncementListScreen` — empat keadaan UI (memuat, gagal, kosong, berhasil).
- Filter kategori tidak memicu request baru ke server.
- Tap kartu membuka halaman detail.

## Tangkapan Layar

### 1. Keadaan Memuat

Saat aplikasi sedang mengambil data dari server, ditampilkan indikator
putar dan teks "Memuat pengumuman…".

![Keadaan Memuat](assets/screenshots/01_memuat.png)

### 2. Keadaan Gagal

Saat koneksi ke server gagal (mis. Wi-Fi dimatikan atau timeout),
ditampilkan pesan error spesifik dan tombol **Coba Lagi**.

![Keadaan Gagal](assets/screenshots/02_gagal.png)

### 3. Keadaan Kosong

Saat respons dari server sukses tetapi tidak ada data yang cocok dengan
filter kategori, ditampilkan pesan "Tidak ada pengumuman untuk kategori …".

![Keadaan Kosong](assets/screenshots/03_kosong.png)

### 4. Keadaan Berhasil

Saat data berhasil dimuat, ditampilkan daftar kartu pengumuman.
Menekan kartu membuka halaman detail.

![Keadaan Berhasil](assets/screenshots/04_berhasil.png)

## Catatan Teknis

### Endpoint

Endpoint `jsonplaceholder.typicode.com/posts` hanya menyediakan `id`,
`title`, dan `body`. Empat field lain yang dibutuhkan model
(`author`, `category`, `date`, `readCount`) diisi di sisi klien setelah
respons diterima, agar model `Announcement` tetap utuh.

### Nilai Cadangan di `fromJson`

Setiap field di `Announcement.fromJson` memiliki nilai cadangan sehingga
respons parsial dari server tidak pernah menyebabkan crash:

| Field       | Cadangan                    |
| ----------- | --------------------------- |
| `id`        | `0`                         |
| `title`     | `'Tanpa Judul'`             |
| `content`   | `''` (atau `body` jika ada) |
| `author`    | `'Admin Jurusan'`           |
| `category`  | `'Akademik'`                |
| `date`      | `'2026-09-01'`              |
| `readCount` | `0`                         |

### Kepemilikan `http.Client`

`AnnouncementApi` melacak apakah `http.Client` dibuat sendiri atau
disuntikkan dari luar. Hanya klien yang dibuat sendiri yang ditutup pada
`dispose()`. Ini memudahkan pengujian dengan `MockClient` tanpa
menutup klien palsu yang masih dipakai.

## Lisensi

Proyek ini dibuat untuk keperluan praktikum mata kuliah Mobile Development
di Politeknik Negeri Banyuwangi (Poliwangi). Tidak untuk dipublikasikan.
