import 'package:flutter/material.dart';

class CustomPhoneField extends StatelessWidget {
  final TextEditingController controller;
  const CustomPhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0XFFE2E5F0)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Image.network('https://flagcdn.com/w20/bd.png', width: 20),
          const SizedBox(width: 8),
          const Text("+880", style: TextStyle(fontSize: 16)),
          const Icon(Icons.keyboard_arrow_down, size: 20),
          const VerticalDivider(),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "0000000000",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}