import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modul_04/models/announcement.dart';
import '../providers/announcement_provider.dart';
import '../widgets/announcement_card.dart';
import 'announcement_detail_screen.dart';

class AnnouncementListScreen extends ConsumerWidget {
  const AnnouncementListScreen({super.key});

  static const List<String> _kategori = <String>[
    'Semua',
    'Akademik',
    'Beasiswa',
    'Kegiatan',
    'Prestasi',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Announcement>> asyncAnnouncements =
    ref.watch(announcementsProvider);
    final String kategoriTerpilih = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal Pengumuman TRPL'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Segarkan Data',
            onPressed: () => ref.invalidate(announcementsProvider),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          _buildBarisFilter(ref, kategoriTerpilih),
          const Divider(height: 1),
          Expanded(
            child: asyncAnnouncements.when(
              loading: _buildMemuat,
              error: (Object err, StackTrace _) =>
                  _buildGagal(context, ref, err),
              data: (List<Announcement> items) => items.isEmpty
                  ? _buildKosong(context, kategoriTerpilih)
                  : _buildDaftar(context, ref, items),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarisFilter(WidgetRef ref, String terpilih) {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: _kategori.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int index) {
          final String kategori = _kategori[index];
          return ChoiceChip(
            label: Text(kategori),
            selected: kategori == terpilih,
            onSelected: (_) =>
                ref.read(selectedCategoryProvider.notifier).select(kategori),
          );
        },
      ),
    );
  }

  Widget _buildMemuat() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Memuat pengumuman…'),
        ],
      ),
    );
  }

  Widget _buildGagal(BuildContext context, WidgetRef ref, Object error) {
    final String pesan = error.toString().replaceFirst('Exception: ', '');
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.cloud_off,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            const Text(
              'Gagal memuat data',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(pesan, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () => ref.invalidate(announcementsProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKosong(BuildContext context, String kategori) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              kategori == 'Semua'
                  ? 'Belum ada pengumuman.'
                  : 'Tidak ada pengumuman untuk kategori "$kategori".',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaftar(
      BuildContext context,
      WidgetRef ref,
      List<Announcement> daftar,
      ) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(announcementsProvider);
        await ref.read(announcementsProvider.future);
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: daftar.length,
        itemBuilder: (BuildContext context, int index) {
          final Announcement item = daftar[index];
          return AnnouncementCard(
            announcement: item,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) =>
                      AnnouncementDetailScreen(announcement: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}