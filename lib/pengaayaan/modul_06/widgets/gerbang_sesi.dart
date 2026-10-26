import 'package:flutter/material.dart';
import '../controllers/sesi_controller.dart';

class GerbangSesi extends StatelessWidget {
  final SesiController controller;
  final Widget Function(BuildContext) form;
  final Widget Function(BuildContext, dynamic) beranda;
  final Widget Function(BuildContext, dynamic) profil;

  const GerbangSesi({
    super.key,
    required this.controller,
    required this.form,
    required this.beranda,
    required this.profil,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {

        if (controller.status != StatusSesi.masuk) {
          return form(context);
        }


        if (controller.diHalamanProfil) {
          return profil(context, controller.sesi!);
        }

        return beranda(context, controller.sesi!);
      },
    );
  }
}