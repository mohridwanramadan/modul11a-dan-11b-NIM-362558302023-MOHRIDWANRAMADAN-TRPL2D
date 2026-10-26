import 'package:flutter/material.dart';

import 'screens/announcement_list_screen.dart';

class Modul04App extends StatelessWidget {
  const Modul04App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modul 04 — Fase B (Riverpod + Dio)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0284C7)),
        useMaterial3: true,
      ),
      home: const AnnouncementListScreen(),
    );
  }
}