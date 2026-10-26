import 'dart:async';
import 'package:flutter/material.dart';
import '../models/sesi_pengguna.dart';

class KartuSesi extends StatefulWidget {
  final SesiPengguna sesi;
  final DateTime sekarang;
  final VoidCallback? onKeluar;
  final bool sedangKeluar;

  const KartuSesi({
    super.key,
    required this.sesi,
    required this.sekarang,
    this.onKeluar,
    this.sedangKeluar = false,
  });

  @override
  State<KartuSesi> createState() => _KartuSesiState();
}

class _KartuSesiState extends State<KartuSesi> {
  late Timer _timer;
  late Duration _sisaWaktu;

  @override
  void initState() {
    super.initState();
    _sisaWaktu = widget.sesi.sisaWaktu(DateTime.now());

    // ✅ LATIHAN 2: Timer berjalan setiap detik
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          // Perbarui sisa waktu berdasarkan jam saat ini
          _sisaWaktu = widget.sesi.sisaWaktu(DateTime.now());
        });
      }
    });
  }

  @override
  void dispose() {
    // ✅ LATIHAN 2: Wajib di-cancel untuk mencegah memory leak
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Cek apakah sisa waktu < 5 menit dan belum kedaluwarsa
    final bool kritis = _sisaWaktu.inMinutes < 5 && _sisaWaktu.inSeconds > 0;

    // Format teks tampilan
    final String teksWaktu = _sisaWaktu.inSeconds <= 0
        ? 'Kedaluwarsa'
        : '${_sisaWaktu.inMinutes} mnt ${_sisaWaktu.inSeconds % 60} dtk';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${widget.sesi.nama}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Email: ${widget.sesi.email}'),
            const Divider(),
            Text(
              'Sisa Waktu: $teksWaktu',
              style: TextStyle(
                // ✅ LATIHAN 2: Warna merah jika kritis
                color: kritis ? Colors.red : Colors.black,
                fontWeight: kritis ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: widget.sedangKeluar ? null : widget.onKeluar,
                icon: const Icon(Icons.logout),
                label: Text(widget.sedangKeluar ? 'Keluar...' : 'Keluar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}