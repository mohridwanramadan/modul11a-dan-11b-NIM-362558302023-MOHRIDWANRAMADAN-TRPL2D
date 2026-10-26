import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../modul_04/models/announcement.dart';

class AnnouncementRemoteDataSource {
  AnnouncementRemoteDataSource({Dio? dio})
      : _dio = dio ??
      Dio(
        BaseOptions(
          baseUrl: 'https://jsonplaceholder.typicode.com',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: <String, dynamic>{
            'Accept': 'application/json',
            'User-Agent': 'PoliwangiMobileApp/1.0',
          },
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          if (kDebugMode) {
            debugPrint('→ ${options.method} ${options.uri}');
          }
          handler.next(options);
        },
        onResponse:
            (Response<dynamic> response, ResponseInterceptorHandler handler) {
          if (kDebugMode) {
            debugPrint(
              '← ${response.statusCode} ${response.requestOptions.uri}',
            );
          }
          handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          if (kDebugMode) {
            debugPrint(
              '✗ ${e.type} ${e.requestOptions.uri} — ${e.message}',
            );
          }
          handler.next(e);
        },
      ),
    );
  }

  final Dio _dio;

  static const List<String> _kategori = <String>[
    'Akademik',
    'Beasiswa',
    'Kegiatan',
    'Prestasi',
  ];

  Future<List<Announcement>> fetchAnnouncements({String? category}) async {
    final Response<List<dynamic>> res = await _dio.get<List<dynamic>>(
      '/posts',
      queryParameters: <String, dynamic>{'limit': 10},
    );

    final List<dynamic> rows = res.data ?? <dynamic>[];

    final List<Announcement> items = List<Announcement>.generate(
      rows.length,
          (int i) {
        final Map<String, dynamic> raw = rows[i] as Map<String, dynamic>;
        return Announcement.fromJson(<String, dynamic>{
          'id': raw['id'],
          'title': raw['title'],
          'content': raw['body'],
          'author': 'Bagian Akademik Poliwangi',
          'category': _kategori[i % _kategori.length],
          'date': '2026-09-${(i % 28 + 1).toString().padLeft(2, '0')}',
          'readCount': (i + 1) * 37,
        });
      },
      growable: false,
    );

    if (category == null || category == 'Semua') return items;
    return items
        .where(
          (Announcement a) =>
      a.category.toLowerCase() == category.toLowerCase(),
    )
        .toList(growable: false);
  }
}