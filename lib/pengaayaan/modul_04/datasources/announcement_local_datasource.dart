import '../../../modul_04/models/announcement.dart';

class AnnouncementLocalDataSource {
  const AnnouncementLocalDataSource();

  Future<List<Announcement>> fetchAnnouncements({String? category}) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    final List<Announcement> all = Announcement.getSampleAnnouncements();
    if (category == null || category == 'Semua') return all;

    return all
        .where(
          (Announcement a) =>
      a.category.toLowerCase() == category.toLowerCase(),
    )
        .toList(growable: false);
  }
}