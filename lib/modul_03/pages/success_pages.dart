import 'package:flutter/material.dart';

class SuccessPages extends StatelessWidget {
  const SuccessPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ikon centang hijau
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 70,
              ),
            ),
            const SizedBox(height: 30),

            // Judul
            const Text(
              'Pesanan Berhasil!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Deskripsi
            const Text(
              'Nasi Goreng sedang diproses.\nTerima kasih telah memesan di Kantin Kampus.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Tombol Kembali ke Menu
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Kembali ke Menu'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}