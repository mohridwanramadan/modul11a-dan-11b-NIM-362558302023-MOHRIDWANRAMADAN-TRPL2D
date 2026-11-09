import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modul_1/modul_11/data/sumber_tugas_contoh.dart';
import 'package:modul_1/modul_11/domain/filter_tugas.dart';
import 'package:modul_1/modul_11/domain/tugas_performa.dart';
import 'package:modul_1/modul_11/modul_11_app.dart';
import 'package:modul_1/pengayaan/modul_11/data/sumber_tugas_berhalaman.dart';
import 'package:modul_1/pengayaan/modul_11/presentation/pengendali_halaman.dart';
import 'package:modul_1/pengayaan/modul_11/screens/daftar_berhalaman_screen.dart';

const _pencarian = ValueKey('task-search');
const _daftar = ValueKey('task-list');

void main() {
  group('Data dan saringTugas', () {
    final sumber = buatTugasContoh();

    test('1000 tugas dengan 250 selesai yang tersebar', () {
      final selesai = sumber.where((t) => t.status == StatusTugas.selesai);
      expect(sumber, hasLength(1000));
      expect(selesai, hasLength(250));
      expect(selesai.first.nomor, 4);
      expect(selesai.map((t) => t.mataKuliah).toSet(), hasLength(8));
    });

    test('saringTugas menormalkan kapitalisasi dan spasi tepi', () {
      final hasil = saringTugas(
        sumber,
        const KriteriaFilter(kueri: ' TUGAS PRAKTIKUM 0002 '),
      );
      expect(hasil.single.nomor, 2);
      expect(hasil.single.status, StatusTugas.aktif);
    });

    test(
      'saringTugas menggabungkan kueri dan status tanpa mengubah sumber',
      () {
        final hasil = saringTugas(
          sumber,
          const KriteriaFilter(
            kueri: 'basis data',
            status: StatusTugas.selesai,
          ),
        );
        expect(hasil, hasLength(31));
        expect(hasil.first.nomor, 18);
        expect(sumber, hasLength(1000));
      },
    );
  });

  group('Fase A', () {
    testWidgets('daftar memakai builder', (tester) async {
      await tester.pumpWidget(const Modul11App());
      final daftar = tester.widget<ListView>(find.byKey(_daftar));
      expect(daftar.childrenDelegate, isA<SliverChildBuilderDelegate>());
    });

    testWidgets('menampilkan jumlah awal dan kartu pertama', (tester) async {
      await tester.pumpWidget(const Modul11App());
      expect(find.text('Menampilkan 1000 dari 1000 tugas'), findsOneWidget);
      expect(find.byKey(const ValueKey('task-card-1')), findsOneWidget);
    });

    testWidgets('pencarian menampilkan satu tugas', (tester) async {
      await tester.pumpWidget(const Modul11App());
      await tester.enterText(find.byKey(_pencarian), 'tugas praktikum 0002');
      await tester.pump();
      expect(find.text('Menampilkan 1 dari 1000 tugas'), findsOneWidget);
      expect(find.byKey(const ValueKey('task-card-2')), findsOneWidget);
    });

    testWidgets('gabungan filter bisa menghasilkan keadaan kosong', (
      tester,
    ) async {
      await tester.pumpWidget(const Modul11App());
      await tester.enterText(find.byKey(_pencarian), 'tugas praktikum 0002');
      await tester.tap(find.widgetWithText(FilterChip, 'Selesai'));
      await tester.pump();
      expect(find.text('Menampilkan 0 dari 1000 tugas'), findsOneWidget);
      expect(find.text('Tidak ada tugas yang cocok.'), findsOneWidget);
    });

    testWidgets('urutan pencarian dan filter sesuai langkah modul', (
      tester,
    ) async {
      await tester.pumpWidget(const Modul11App());
      await tester.enterText(find.byKey(_pencarian), 'tugas praktikum 0002');
      await tester.tap(find.widgetWithText(FilterChip, 'Selesai'));
      await tester.pump();
      await tester.enterText(find.byKey(_pencarian), '');
      await tester.pump();
      expect(find.text('Menampilkan 250 dari 1000 tugas'), findsOneWidget);
      expect(find.byKey(const ValueKey('task-card-4')), findsOneWidget);
      await tester.enterText(find.byKey(_pencarian), 'basis data');
      await tester.pump();
      expect(find.text('Menampilkan 31 dari 1000 tugas'), findsOneWidget);
      expect(find.byKey(const ValueKey('task-card-18')), findsOneWidget);
      await tester.tap(find.widgetWithText(FilterChip, 'Semua'));
      await tester.pump();
      expect(find.text('Menampilkan 125 dari 1000 tugas'), findsOneWidget);
    });

    testWidgets('daftar dapat digulir sampai tugas 1000', (tester) async {
      await tester.pumpWidget(const Modul11App());
      final terakhir = find.byKey(const ValueKey('task-card-1000'));
      await tester.scrollUntilVisible(
        terakhir,
        900,
        maxScrolls: 130,
        scrollable: find.descendant(
          of: find.byKey(_daftar),
          matching: find.byType(Scrollable),
        ),
      );
      expect(terakhir, findsOneWidget);
    });
  });

  group('Fase B', () {
    test('simulasi mengembalikan satu halaman dan penanda akhir', () async {
      final sumber = SumberTugasSimulasi(jeda: Duration.zero);
      final awal = await sumber.ambilHalaman(halaman: 1, ukuran: 50);
      final akhir = await sumber.ambilHalaman(halaman: 20, ukuran: 50);
      expect(awal.tugas, hasLength(50));
      expect(awal.adaBerikutnya, isTrue);
      expect(akhir.tugas.last.nomor, 1000);
      expect(akhir.adaBerikutnya, isFalse);
    });

    test('simulasi gagal sekali pada halaman ketiga', () async {
      final sumber = SumberTugasSimulasi(jeda: Duration.zero);
      await expectLater(
        sumber.ambilHalaman(halaman: 3, ukuran: 50),
        throwsStateError,
      );
      final ulang = await sumber.ambilHalaman(halaman: 3, ukuran: 50);
      expect(ulang.tugas.first.nomor, 101);
    });

    test('pengendali mengabaikan permintaan yang bertumpuk', () async {
      final pengendali = PengendaliHalaman(
        SumberTugasSimulasi(jeda: Duration.zero),
      );
      addTearDown(pengendali.dispose);
      final pertama = pengendali.muatBerikutnya();
      expect(pengendali.memuat, isTrue);
      await pengendali.muatBerikutnya();
      await pertama;
      expect(pengendali.tugas, hasLength(50));
    });

    test('coba lagi mengulang halaman yang gagal', () async {
      final pengendali = PengendaliHalaman(
        SumberTugasSimulasi(jeda: Duration.zero),
      );
      addTearDown(pengendali.dispose);
      await pengendali.muatBerikutnya();
      await pengendali.muatBerikutnya();
      await pengendali.muatBerikutnya();
      expect(pengendali.galat, 'Gagal memuat halaman 3.');
      expect(pengendali.tugas, hasLength(100));
      await pengendali.muatBerikutnya();
      expect(pengendali.galat, isNull);
      expect(pengendali.tugas, hasLength(150));
      expect(pengendali.tugas[100].nomor, 101);
    });

    test('pengendali berhenti setelah data habis', () async {
      final pengendali = PengendaliHalaman(
        SumberTugasSimulasi(jeda: Duration.zero, halamanGagalSekali: null),
      );
      addTearDown(pengendali.dispose);
      for (var halaman = 0; halaman < 21; halaman++) {
        await pengendali.muatBerikutnya();
      }
      expect(pengendali.tugas, hasLength(1000));
      expect(pengendali.adaBerikutnya, isFalse);
    });

    testWidgets('layar memuat, menampilkan galat, dan bisa mencoba lagi', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LayarDaftarBerhalaman(
            sumber: SumberTugasSimulasi(
              jeda: const Duration(milliseconds: 100),
              halamanGagalSekali: 1,
            ),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('Gagal memuat halaman 1.'), findsOneWidget);
      await tester.tap(find.text('Coba lagi'));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('task-card-1')), findsOneWidget);
    });
  });
}
