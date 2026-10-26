import '../../../modul_04/models/announcement.dart';
import 'announcement_repository.dart';

class SampleAnnouncementRepository implements AnnouncementRepository {
  /// `List<Announcement>.of(...)` WAJIB: `getSampleAnnouncements()`
  /// mengembalikan list `const` yang tidak dapat diubah. Tanpa
  /// penyalinan ini, `_items.add()` akan melempar `UnsupportedError`
  /// saat dijalankan — padahal `flutter analyze` tetap hijau.
  final List<Announcement> _items =
  List<Announcement>.of(Announcement.getSampleAnnouncements());

  @override
  Future<List<Announcement>> getAnnouncements({String? category}) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    if (category == null || category == 'Semua') {
      return List<Announcement>.unmodifiable(_items);
    }
    return _items
        .where(
          (Announcement a) =>
      a.category.toLowerCase() == category.toLowerCase(),
    )
        .toList(growable: false);
  }

  @override
  Future<Announcement> addAnnouncement(Announcement announcement) async {
    final Announcement baru = Announcement(
      id: DateTime.now().millisecondsSinceEpoch,
      title: announcement.title,
      content: announcement.content,
      author: announcement.author,
      category: announcement.category,
      date: announcement.date,
      readCount: 0,
    );
    _items.add(baru);
    return baru;
  }
}