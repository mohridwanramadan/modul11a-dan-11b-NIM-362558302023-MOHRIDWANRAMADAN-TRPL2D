import 'package:flutter/material.dart';
import 'package:modul_1/modu_02/academic_dashboard_screen.dart'; // Sesuaikan lokasi file screen Anda

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard Akademik TRPL',
      home: AcademicDashboardScreen(),
    );
  }
}