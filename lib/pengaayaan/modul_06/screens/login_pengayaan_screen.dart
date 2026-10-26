import 'package:flutter/material.dart';
import '../../../modul_06/widgets/field_kata_sandi.dart';
import '../../../modul_06/services/auth_api.dart';
import '../controllers/sesi_controller.dart';
import '../widgets/papan_diagnostik_penyimpanan.dart';

class LoginPengayaanScreen extends StatefulWidget {
  final SesiController controller;
  const LoginPengayaanScreen({super.key, required this.controller});

  @override
  State<LoginPengayaanScreen> createState() => _LoginPengayaanScreenState();
}

class _LoginPengayaanScreenState extends State<LoginPengayaanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _sandi = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _sandi.dispose();
    super.dispose();
  }

  void _kirim() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.controller.login(_email.text, _sandi.text);
  }

  @override
  Widget build(BuildContext context) {
    final sibuk = widget.controller.status == StatusSesi.memproses;
    final pesan = widget.controller.pesanError;

    return Scaffold(
      appBar: AppBar(title: const Text('Login (Fase B)')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (pesan != null) ...[
            Text(pesan, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
          ],
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _email,
                  enabled: !sibuk,
                  decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                  validator: (v) => (v ?? '').isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 16),
                FieldKataSandi(
                  controller: _sandi,
                  enabled: !sibuk,
                  validator: (v) => (v ?? '').isEmpty ? 'Wajib diisi' : null,
                  onSubmitted: _kirim,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: sibuk ? null : _kirim,
            child: Text(sibuk ? 'Memproses...' : 'Masuk'),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: sibuk ? null : () {
              _email.text = AuthApi.emailDemo;
              _sandi.text = AuthApi.sandiDemo;
            },
            child: const Text('Isi Otomatis'),
          ),
          const SizedBox(height: 32),
          PapanDiagnostikPenyimpanan(repository: widget.controller.repository),
        ],
      ),
    );
  }
}