import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modul_04/models/announcement.dart';
import '../repositories/announcement_repository.dart';
import '../repositories/announcement_repository_impl.dart';
import '../repositories/sample_announcement_repository.dart';

/// Dibaca dari `--dart-define=USE_SAMPLE_DATA=true`.
const bool kUseSampleData = bool.fromEnvironment('USE_SAMPLE_DATA');

final useSampleDataProvider = Provider<bool>((ref) => kUseSampleData);

final announcementRepositoryProvider = Provider<AnnouncementRepository>((ref) {
  if (ref.watch(useSampleDataProvider)) {
    return SampleAnnouncementRepository();
  }
  return AnnouncementRepositoryImpl();
});

class SelectedCategory extends Notifier<String> {
  @override
  String build() => 'Semua';

  void select(String value) => state = value;
}

final selectedCategoryProvider =
NotifierProvider<SelectedCategory, String>(SelectedCategory.new);

final announcementsProvider = FutureProvider<List<Announcement>>((ref) async {
  final AnnouncementRepository repo =
  ref.watch(announcementRepositoryProvider);
  final String category = ref.watch(selectedCategoryProvider);

  return repo.getAnnouncements(category: category);
});