import 'package:flutter/material.dart';

import '../data/sumber_tugas_contoh.dart';
import '../domain/filter_tugas.dart';
import '../domain/tugas_performa.dart';
import '../widgets/kartu_tugas_performa.dart';

class LayarDaftarTugasPerforma extends StatefulWidget {
  const LayarDaftarTugasPerforma({super.key});

  @override
  State<LayarDaftarTugasPerforma> createState() =>
      _LayarDaftarTugasPerformaState();
}

class _LayarDaftarTugasPerformaState extends State<LayarDaftarTugasPerforma> {
  final List<TugasPerforma> _semuaTugas = buatTugasContoh();
  KriteriaFilter _kriteria = const KriteriaFilter();
  late List<TugasPerforma> _hasil = _semuaTugas;

  void _terapkan(KriteriaFilter kriteria) {
    setState(() {
      _kriteria = kriteria;
      _hasil = saringTugas(_semuaTugas, kriteria);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas Kuliah'),
        actions: [
          PopupMenuButton<String>(
            key: const ValueKey('course-filter'),
            tooltip: 'Filter mata kuliah',
            icon: const Icon(Icons.filter_list),
            initialValue: _kriteria.mataKuliah ?? '',
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: '',
                child: Text('Semua mata kuliah'),
              ),
              for (final nama in daftarMataKuliahContoh)
                PopupMenuItem<String>(value: nama, child: Text(nama)),
            ],
            onSelected: (pilihan) => _terapkan(
              _kriteria.salinDengan(
                mataKuliah: pilihan,
                hapusMataKuliah: pilihan.isEmpty,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: TextField(
                key: const ValueKey('task-search'),
                onChanged: (kueri) =>
                    _terapkan(_kriteria.salinDengan(kueri: kueri)),
                decoration: const InputDecoration(
                  labelText: 'Cari tugas atau mata kuliah',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Wrap(
                spacing: 8,
                children: [
                  _filterChip('Semua', null),
                  _filterChip('Aktif', StatusTugas.aktif),
                  _filterChip('Selesai', StatusTugas.selesai),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: Text(
                'Menampilkan ${_hasil.length} dari ${_semuaTugas.length} tugas',
                key: const ValueKey('result-count'),
              ),
            ),
            Expanded(
              child: _hasil.isEmpty
                  ? const Center(child: Text('Tidak ada tugas yang cocok.'))
                  : ListView.builder(
                      key: const ValueKey<String>('task-list'),
                      itemCount: _hasil.length,
                      itemBuilder: (context, index) =>
                          KartuTugasPerforma(tugas: _hasil[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterChip(String label, StatusTugas? status) => FilterChip(
    label: Text(label),
    selected: _kriteria.status == status,
    onSelected: (_) => _terapkan(
      _kriteria.salinDengan(status: status, hapusStatus: status == null),
    ),
  );
}
