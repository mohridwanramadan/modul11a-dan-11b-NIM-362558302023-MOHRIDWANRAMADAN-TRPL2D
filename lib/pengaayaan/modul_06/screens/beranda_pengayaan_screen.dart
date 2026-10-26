import 'package:flutter/material.dart';
import '../../../modul_06/models/sesi_pengguna.dart';
import '../controllers/sesi_controller.dart';

class BerandaPengayaanScreen extends StatelessWidget {
  final SesiController controller;
  final SesiPengguna sesi;

  const BerandaPengayaanScreen({super.key, required this.controller, required this.sesi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda (Fase B)')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text(sesi.nama),
                subtitle: Text(sesi.email),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ LATIHAN 5: Tombol pindah ke Profil
            ElevatedButton.icon(
              onPressed: () => controller.bukaProfil(),
              icon: const Icon(Icons.person),
              label: const Text('Lihat Profil'),
            ),

            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () => controller.logout(),
              icon: const Icon(Icons.logout),
              label: const Text('Keluar'),
            ),
          ],
        ),
      ),
    );
  }
}