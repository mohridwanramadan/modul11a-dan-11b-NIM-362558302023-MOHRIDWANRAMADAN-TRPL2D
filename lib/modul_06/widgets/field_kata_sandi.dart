import 'package:flutter/material.dart';

class FieldKataSandi extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool enabled;
  final VoidCallback? onSubmitted;

  const FieldKataSandi({
    super.key,
    required this.controller,
    this.validator,
    this.enabled = true,
    this.onSubmitted,
  });

  @override
  State<FieldKataSandi> createState() => _FieldKataSandiState();
}

class _FieldKataSandiState extends State<FieldKataSandi> {
  bool _terlihat = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      obscureText: !_terlihat,
      autocorrect: false,
      enableSuggestions: false,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => widget.onSubmitted?.call(),
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: 'Kata Sandi',
        prefixIcon: const Icon(Icons.lock_outline_rounded),
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(_terlihat ? Icons.visibility_off : Icons.visibility),
          onPressed: widget.enabled
              ? () => setState(() => _terlihat = !_terlihat)
              : null,
        ),
      ),
    );
  }
}