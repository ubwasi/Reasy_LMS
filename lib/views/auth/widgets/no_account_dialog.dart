import 'package:flutter/material.dart';

class NoAccountDialog {
  static void show(BuildContext context, {required VoidCallback onCreateAccount}) {
    showDialog(
      context: context,
      barrierDismissible: false, // বাইরে ক্লিক করলে যাতে বন্ধ না হয়
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // আপনার ডিজাইনের উপরের সার্কেল আইকন
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFFD9ECFF),
              child: Icon(Icons.person_off_outlined, size: 40, color: Color(0xFF246BFD)),
            ),
            const SizedBox(height: 24),

            // এরর টেক্সট
            const Text(
              "Sorry, there is no account with this email.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFF44336),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),

            // সাবটাইটেল
            const Text(
              "Create an account to continue",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF637381), fontSize: 14),
            ),
            const SizedBox(height: 32),

            // বাটন রো
            Row(
              children: [
                // Back বাটন
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Color(0xFF246BFD)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Back", style: TextStyle(color: Color(0xFF246BFD))),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // ডায়ালগ বন্ধ হবে
                      onCreateAccount(); // সাইন-আপ পেজে যাবে
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF246BFD),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: const Text("Create Account", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}