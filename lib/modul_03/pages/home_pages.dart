import 'package:flutter/material.dart';
import 'detail_pages.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kantin Kampus'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gambar nasi goreng
            Image.asset(
              'assets/images/nasgor.png',
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),

            // Nama menu
            const Text(
              'Nasi Goreng',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Harga
            const Text(
              'Rp15.000',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            const SizedBox(height: 12),

            // Deskripsi
            const Text(
              'Nasi goreng dengan telur, ayam, dan sayuran. Menu favorit di kantin kampus!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Tombol Lihat Detail
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailPages(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Lihat Detail'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}