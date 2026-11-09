import 'package:flutter/material.dart';

import '../../../modul_11/widgets/kartu_tugas_performa.dart';
import '../data/sumber_tugas_berhalaman.dart';
import '../presentation/pengendali_halaman.dart';

class LayarDaftarBerhalaman extends StatefulWidget {
  const LayarDaftarBerhalaman({super.key, this.sumber});

  final SumberTugasBerhalaman? sumber;

  @override
  State<LayarDaftarBerhalaman> createState() => _LayarDaftarBerhalamanState();
}

class _LayarDaftarBerhalamanState extends State<LayarDaftarBerhalaman> {
  late final PengendaliHalaman _pengendali;

  @override
  void initState() {
    super.initState();
    _pengendali = PengendaliHalaman(widget.sumber ?? SumberTugasSimulasi());
    _pengendali.muatBerikutnya();
  }

  @override
  void dispose() {
    _pengendali.dispose();
    super.dispose();
  }

  bool _saatGulir(ScrollNotification notifikasi) {
    if (notifikasi is ScrollUpdateNotification &&
        notifikasi.metrics.extentAfter < 400 &&
        _pengendali.adaBerikutnya &&
        !_pengendali.memuat &&
        _pengendali.galat == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _pengendali.galat == null) {
          _pengendali.muatBerikutnya();
        }
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tugas Kuliah — Fase B')),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _pengendali,
          builder: (context, _) => NotificationListener<ScrollNotification>(
            onNotification: _saatGulir,
            child: ListView.builder(
              key: const ValueKey('paged-task-list'),
              itemCount: _pengendali.tugas.length + 1,
              itemBuilder: (context, index) {
                if (index < _pengendali.tugas.length) {
                  return KartuTugasPerforma(tugas: _pengendali.tugas[index]);
                }
                return _bagianAkhir();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _bagianAkhir() {
    final galat = _pengendali.galat;
    if (_pengendali.memuat) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (galat != null) {
      return Column(
        children: [
          Text(galat),
          TextButton(
            onPressed: _pengendali.muatBerikutnya,
            child: const Text('Coba lagi'),
          ),
        ],
      );
    }
    if (!_pengendali.adaBerikutnya) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text('Semua ${_pengendali.tugas.length} tugas sudah dimuat.'),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
