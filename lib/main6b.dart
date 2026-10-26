import 'package:flutter/material.dart';
// Import aplikasi pengayaan (Fase B)
import 'pengaayaan/modul_06/modul_06_pengayaan_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AplikasiUtama());
}

class AplikasiUtama extends StatelessWidget {
  const AplikasiUtama({super.key});

  @override
  Widget build(BuildContext context) {
    // Memanggil Modul 06 Fase B
    return const Modul06PengayaanApp();
  }
}