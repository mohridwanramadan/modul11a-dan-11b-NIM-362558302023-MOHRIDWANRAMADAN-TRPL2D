import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modul_1/modul_11/data/sumber_tugas_contoh.dart';
import 'package:modul_1/modul_11/domain/filter_tugas.dart';
import 'package:modul_1/modul_11/domain/tugas_performa.dart';
import 'package:modul_1/modul_11/modul_11_app.dart' show Modul11App;

void main() {
  test('filter Basis Data dan status selesai menghasilkan 31 tugas', () {
    final semua = buatTugasContoh();
    const kriteria = KriteriaFilter(
      mataKuliah: 'Basis Data',
      status: StatusTugas.selesai,
    );

    final hasil = saringTugas(semua, kriteria);

    expect(hasil, hasLength(31));
    expect(hasil.first.nomor, 18);
    expect(hasil.every((t) => t.mataKuliah == 'Basis Data'), isTrue);
    expect(hasil.every((t) => t.status == StatusTugas.selesai), isTrue);
    expect(semua, hasLength(1000));
  });

  testWidgets('pilihan mata kuliah mengubah jumlah hasil', (tester) async {
    await tester.pumpWidget(const Modul11App());

    expect(find.text('Menampilkan 1000 dari 1000 tugas'), findsOneWidget);
    expect(find.text('Semua mata kuliah'), findsNothing);

    final menu = find.byKey(const ValueKey('course-filter'));

    await tester.tap(menu);
    await tester.pumpAndSettle();
    await tester.tap(
      find.widgetWithText(PopupMenuItem<String>, 'Basis Data').hitTestable(),
    );
    await tester.pumpAndSettle();

    expect(find.text('Menampilkan 125 dari 1000 tugas'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilterChip, 'Selesai'));
    await tester.pumpAndSettle();

    expect(find.text('Menampilkan 31 dari 1000 tugas'), findsOneWidget);

    await tester.tap(menu);
    await tester.pumpAndSettle();
    await tester.tap(
      find
          .widgetWithText(PopupMenuItem<String>, 'Semua mata kuliah')
          .hitTestable(),
    );
    await tester.pumpAndSettle();

    expect(find.text('Menampilkan 250 dari 1000 tugas'), findsOneWidget);
  });
}
