import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'services/auth_api.dart';
import 'services/sesi_memori.dart';

class Modul06App extends StatefulWidget {
  const Modul06App({super.key});

  @override
  State<Modul06App> createState() => _Modul06AppState();
}

class _Modul06AppState extends State<Modul06App> {
  late final SesiMemori _sesiMemori = SesiMemori();
  late final AuthApi _api = const AuthApi();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modul 06 — Login & Session Dasar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0284C7)),
        useMaterial3: true,
      ),
      home: LoginScreen(api: _api, sesiMemori: _sesiMemori),
    );
  }
}