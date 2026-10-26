import 'package:flutter/material.dart';
import 'modul_06/modul_06_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AplikasiUtama());
}

class AplikasiUtama extends StatelessWidget {
  const AplikasiUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return const Modul06App(); // Panggil Fase A
  }
}