import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:modul_1/modul_04/models/announcement.dart';
import 'package:modul_1/pengaayaan/modul_04/providers/announcement_provider.dart';
import 'package:modul_1/pengaayaan/modul_04/repositories/announcement_repository.dart';
import 'package:modul_1/pengaayaan/modul_04/repositories/sample_announcement_repository.dart';

/// Repository palsu untuk pengujian.
class FakeAnnouncementRepository implements AnnouncementRepository {
  FakeAnnouncementRepository({this.gagal = false, this.items = const []});

  final bool gagal;
  final List<Announcement> items;

  @override
  Future<List<Announcement>> getAnnouncements({String? category}) async {
    if (gagal) throw Exception('Gagal mengambil data');
    if (category == null || category == 'Semua') return items;
    return items
        .where(
          (Announcement a) =>
      a.category.toLowerCase() == category.toLowerCase(),
    )
        .toList(growable: false);
  }

  @override
  Future<Announcement> addAnnouncement(Announcement announcement) async {
    return announcement;
  }
}

Announcement _buat(String judul, String kategori) => Announcement(
  id: judul.hashCode,
  title: judul,
  content: 'isi',
  author: 'Admin',
  category: kategori,
  date: '2026-09-01',
  readCount: 0,
);

void main() {
  group('announcementsProvider', () {
    test('mengembalikan daftar ketika repository sukses', () async {
      final container = ProviderContainer(
        overrides: [
          announcementRepositoryProvider.overrideWithValue(
            FakeAnnouncementRepository(
              items: <Announcement>[_buat('Judul', 'Akademik')],
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final List<Announcement> hasil =
      await container.read(announcementsProvider.future);

      expect(hasil.length, 1);
      expect(hasil.first.title, 'Judul');
    });

    test('melempar error ketika repository gagal (retry dimatikan)', () async {
      final container = ProviderContainer(
        overrides: [
          announcementRepositoryProvider.overrideWithValue(
            FakeAnnouncementRepository(gagal: true),
          ),
        ],
        // ⬇️ KUNCI: matikan auto-retry Riverpod 3.
        // Kalau baris ini dihapus, test akan menggantung sampai timeout.
        retry: (int retryCount, Object error) => null,
      );
      addTearDown(container.dispose);

      await expectLater(
        container.read(announcementsProvider.future),
        throwsA(isA<Exception>()),
      );
    });

    test('ganti kategori memicu reload dan filter berubah', () async {
      final container = ProviderContainer(
        overrides: [
          announcementRepositoryProvider.overrideWithValue(
            FakeAnnouncementRepository(
              items: <Announcement>[
                _buat('A', 'Akademik'),
                _buat('B', 'Prestasi'),
              ],
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final semua = await container.read(announcementsProvider.future);
      expect(semua.length, 2);

      container.read(selectedCategoryProvider.notifier).select('Prestasi');
      final prestasi = await container.read(announcementsProvider.future);
      expect(prestasi.length, 1);
      expect(prestasi.first.category, 'Prestasi');
    });
  });

  group('SampleAnnouncementRepository', () {
    test('addAnnouncement tidak melempar UnsupportedError', () async {
      final repo = SampleAnnouncementRepository();
      final awal = await repo.getAnnouncements();

      await repo.addAnnouncement(_buat('Baru', 'Kegiatan'));
      final sesudah = await repo.getAnnouncements();

      expect(sesudah.length, awal.length + 1);
    });
  });
}