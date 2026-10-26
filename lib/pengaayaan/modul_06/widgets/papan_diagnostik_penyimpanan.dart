import 'package:flutter/material.dart';
import '../repositories/sesi_repository.dart';

class PapanDiagnostikPenyimpanan extends StatefulWidget {
  final SesiRepository repository;
  const PapanDiagnostikPenyimpanan({super.key, required this.repository});

  @override
  State<PapanDiagnostikPenyimpanan> createState() => _PapanDiagnostikPenyimpananState();
}

class _PapanDiagnostikPenyimpananState extends State<PapanDiagnostikPenyimpanan> {
  String? _hasilIntip;
  bool _sedangMengintip = false;

  Future<void> _intip() async {
    setState(() => _sedangMengintip = true);
    final hasil = await widget.repository.intipMentah();
    if (!mounted) return;
    setState(() {
      _hasilIntip = hasil;
      _sedangMengintip = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade50,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Penyimpanan: ${widget.repository.nama}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _sedangMengintip ? null : _intip,
              child: Text(_sedangMengintip ? 'Mengintip...' : 'Intip Isi Penyimpanan'),
            ),
            if (_hasilIntip != null) ...[
              const SizedBox(height: 8),
              Text('Hasil Intip: $_hasilIntip', style: const TextStyle(fontSize: 12)),
            ] else if (_hasilIntip == null && !_sedangMengintip) ...[
              const SizedBox(height: 8),
              const Text('Belum diintip / Hasil kosong (Aman).', style: TextStyle(fontSize: 12)),
            ]
          ],
        ),
      ),
    );
  }
}