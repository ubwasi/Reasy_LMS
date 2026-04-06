import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final String? errorText;

  const AuthTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    this.errorText,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Color(0XFFA0A4B8),
              fontSize: 16,
              fontWeight: FontWeight.w200,
            ),
            filled: true,
            fillColor: Colors.white,

            prefixIcon: widget.errorText != null
                ? const Icon(Icons.error_outline, color: Colors.red, size: 20)
                : null,
            errorText: widget.errorText,
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: widget.errorText != null ? Colors.red : const Color(0XFFE2E5F0),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: widget.errorText != null ? Colors.red : const Color(0XFFE2E5F0),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: const Color(0XFFA0A4B8),
              ),
              onPressed: () => setState(() => _obscureText = !_obscureText),
            )
                : null,
          ),
        ),
      ],
    );
  }
}