import 'package:flutter/material.dart';
import '../../../modul_06/services/auth_api.dart';
import '../../../modul_06/services/sesi_memori.dart';
import 'storage/penyimpanan_aman_platform.dart';
import 'repositories/memori_sesi_repository.dart';
import 'repositories/prefs_sesi_repository.dart';
import 'repositories/aman_sesi_repository.dart';
import 'repositories/sesi_repository.dart';
import 'controllers/sesi_controller.dart';
import 'widgets/gerbang_sesi.dart';
import 'screens/login_pengayaan_screen.dart';
import 'screens/beranda_pengayaan_screen.dart';
import 'screens/profil_pengayaan_screen.dart';

class Modul06PengayaanApp extends StatefulWidget {
  const Modul06PengayaanApp({super.key});

  @override
  State<Modul06PengayaanApp> createState() => _Modul06PengayaanAppState();
}

class _Modul06PengayaanAppState extends State<Modul06PengayaanApp> {
  final AuthApi _api = const AuthApi();
  SesiRepository _repository = AmanSesiRepository(const PenyimpananAmanPlatform());
  late SesiController _controller;

  @override
  void initState() {
    super.initState();
    _buatController();
  }

  void _buatController() {
    _controller = SesiController(api: _api, repository: _repository);
    _controller.pulihkan();
  }

  void _gantiPenyimpanan(SesiRepository baru) {
    setState(() {
      _repository = baru;
      _buatController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modul 06 — Fase B',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fase B - Pengayaan'),
          actions: [
            PopupMenuButton<SesiRepository>(
              icon: const Icon(Icons.storage),
              tooltip: 'Ganti Penyimpanan',
              onSelected: _gantiPenyimpanan,
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: MemoriSesiRepository(SesiMemori()),
                  child: const Text('Memori (Fase A)'),
                ),
                PopupMenuItem(
                  value: PrefsSesiRepository(),
                  child: const Text('SharedPreferences (Bocor)'),
                ),
                PopupMenuItem(
                  value: AmanSesiRepository(const PenyimpananAmanPlatform()),
                  child: const Text('Secure Storage (Aman)'),
                ),
              ],
            ),
          ],
        ),
        body: GerbangSesi(
          controller: _controller,
          form: (ctx) => LoginPengayaanScreen(controller: _controller),
          beranda: (ctx, sesi) => BerandaPengayaanScreen(controller: _controller, sesi: sesi),


          profil: (ctx, sesi) => ProfilPengayaanScreen(
            sesi: sesi,
            onKembali: () => _controller.tutupProfil(),
          ),
        ),
      ),
    );
  }
}