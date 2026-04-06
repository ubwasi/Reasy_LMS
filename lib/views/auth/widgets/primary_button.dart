import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height *0.059,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: isEnabled ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isEnabled ? const Color(0xFF2563EB) : const Color(0xFFB1D7FF),
              foregroundColor: Colors.white,
              elevation: isEnabled ? 3 : 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              disabledBackgroundColor: const Color(0xFFC5DCFF),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isEnabled ? Colors.white : Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ),


      ],
    );
  }
}