import 'package:flutter/material.dart';

import '../domain/tugas_performa.dart';

class KartuTugasPerforma extends StatelessWidget {
  const KartuTugasPerforma({super.key, required this.tugas});

  final TugasPerforma tugas;

  @override
  Widget build(BuildContext context) => Card(
    key: ValueKey('task-card-${tugas.nomor}'),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    child: ListTile(
      leading: const CircleAvatar(child: Icon(Icons.assignment_outlined)),
      title: Text(tugas.judul),
      subtitle: Text(tugas.mataKuliah),
      trailing: Text(tugas.status == StatusTugas.selesai ? 'Selesai' : 'Aktif'),
    ),
  );
}
