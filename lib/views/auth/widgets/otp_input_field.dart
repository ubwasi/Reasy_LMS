import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/services/database_helper.dart';
import '../success_screen.dart';

class OTPInputScreen extends StatefulWidget {
  final String verificationId;
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;

  const OTPInputScreen({
    super.key,
    required this.verificationId,
    required this.fullName,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  @override
  State<OTPInputScreen> createState() => _OTPInputScreenState();
}

class _OTPInputScreenState extends State<OTPInputScreen> {
  final List<TextEditingController> controllers = List.generate(
    6,
        (index) => TextEditingController(),
  );

  bool _isLoading = false;
  Future<void> _verifyOtpAndSignUp() async {
    String otp = controllers.map((e) => e.text).join();

    if (otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter complete OTP")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(widget.fullName);

        final dbHelper = DatabaseHelper();
        await dbHelper.insertUser({
          'name': widget.fullName,
          'email': widget.email,
          'phone': widget.phoneNumber,
        });

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SuccessScreen()),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP: ${e.toString()}"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 23),
            const Text(
              "Verify OTP",
              style: TextStyle(color: Color(0XFF2C3E50), fontSize: 28, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              "Enter the OTP code sent to ${widget.phoneNumber}",
              style: const TextStyle(fontWeight: FontWeight.w400, color: Color(0XFF5E6470)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 54),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 45,
                  child: TextField(
                    controller: controllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0XFFC4CDD5), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0XFF2563EB), width: 1.5),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn’t receive it? "),
                GestureDetector(
                  onTap: () {
                  },
                  child: const Text("Resend OTP", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
            const SizedBox(height: 93),
            GestureDetector(
              onTap: _isLoading ? null : _verifyOtpAndSignUp,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _isLoading ? Colors.grey : const Color(0XFF2563EB),
                ),
                child: Center(
                  child: _isLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text("Next", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white)),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}