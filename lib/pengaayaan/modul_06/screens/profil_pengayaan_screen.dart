import 'package:flutter/material.dart';
import '../../../modul_06/models/sesi_pengguna.dart';

class ProfilPengayaanScreen extends StatelessWidget {
  final SesiPengguna sesi;
  final VoidCallback onKembali;

  const ProfilPengayaanScreen({
    super.key,
    required this.sesi,
    required this.onKembali
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Pengguna')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            const SizedBox(height: 20),
            Text('Nama: ${sesi.nama}', style: const TextStyle(fontSize: 18)),
            Text('Email: ${sesi.email}'),
            Text('Peran: ${SesiPengguna.labelPeran(sesi.peran)}'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: onKembali,
              child: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    );
  }
}