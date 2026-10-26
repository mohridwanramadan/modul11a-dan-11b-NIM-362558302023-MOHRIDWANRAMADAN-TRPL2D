import 'package:dio/dio.dart';

import '../../../modul_04/models/announcement.dart';
import '../datasources/announcement_remote_datasource.dart';
import 'announcement_repository.dart';

class AnnouncementRepositoryImpl implements AnnouncementRepository {
  AnnouncementRepositoryImpl({AnnouncementRemoteDataSource? source})
      : _source = source ?? AnnouncementRemoteDataSource();

  final AnnouncementRemoteDataSource _source;

  @override
  Future<List<Announcement>> getAnnouncements({String? category}) async {
    try {
      return await _source.fetchAnnouncements(category: category);
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    }
  }

  @override
  Future<Announcement> addAnnouncement(Announcement announcement) async {
    return announcement;
  }

  String _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Koneksi ke server timeout. Periksa sambungan internet Anda.';
      case DioExceptionType.connectionError:
        return 'Gagal terhubung ke server. '
            'Periksa koneksi data atau Wi-Fi Anda.';
      case DioExceptionType.badResponse:
        return 'Server merespons dengan kesalahan '
            '(${e.response?.statusCode}).';
      default:
        return 'Terjadi kendala jaringan: '
            '${e.message ?? 'Kesalahan tidak diketahui'}';
    }
  }
}