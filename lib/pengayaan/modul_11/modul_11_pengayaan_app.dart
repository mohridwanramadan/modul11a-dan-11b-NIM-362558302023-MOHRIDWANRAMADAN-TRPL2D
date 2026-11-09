import 'package:flutter/material.dart';

import 'screens/daftar_berhalaman_screen.dart';

class Modul11PengayaanApp extends StatelessWidget {
  const Modul11PengayaanApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Modul 11 — Pagination',
    theme: ThemeData(
      colorSchemeSeed: const Color(0xFF0E7490),
      useMaterial3: true,
    ),
    home: const LayarDaftarBerhalaman(),
  );
}
