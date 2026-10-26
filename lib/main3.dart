import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pengaayaan/modul_04/modul_04_app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: Modul04App(),
    ),
  );
}