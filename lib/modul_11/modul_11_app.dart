import 'package:flutter/material.dart';

import 'screens/daftar_tugas_performa_screen.dart';

class Modul11App extends StatelessWidget {
  const Modul11App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Modul 11 — Optimasi Daftar Tugas',
    theme: ThemeData(
      colorSchemeSeed: const Color(0xFF0E7490),
      useMaterial3: true,
    ),
    home: const LayarDaftarTugasPerforma(),
  );
}
