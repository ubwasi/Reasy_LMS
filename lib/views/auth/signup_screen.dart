import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ready_lms/views/auth/widgets/auth_text_field.dart';
import 'package:ready_lms/views/auth/widgets/custom_phone_field.dart';
import 'package:ready_lms/views/auth/widgets/otp_input_field.dart';
import 'package:ready_lms/views/auth/widgets/primary_button.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _verifyPhone() async {
    String rawPhone = _phoneController.text.trim();
    if (rawPhone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your phone number")),
      );
      return;
    }

    setState(() => _isLoading = true);


    String processedPhone = rawPhone;
    if (processedPhone.startsWith('0')) {
      processedPhone = processedPhone.substring(1);
    }

    String firebaseNumber = "+880$processedPhone";

    String dbPhoneNumber = "0$processedPhone";

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: firebaseNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Verification Failed: ${e.message}"),
              backgroundColor: Colors.red,
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() => _isLoading = false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OTPInputScreen(
                verificationId: verificationId,
                fullName: _fullNameController.text.trim(),
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
                phoneNumber: dbPhoneNumber,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() => _isLoading = false);
        },
      );
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  void dispose() {

    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 40),
        child: Column(
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Color(0XFF2C3E50),
              ),
            ),
            const SizedBox(height: 48),

            AuthTextField(hintText: "Full name", controller: _fullNameController),
            const SizedBox(height: 20),

            AuthTextField(hintText: "Email address", controller: _emailController),
            const SizedBox(height: 20),

            CustomPhoneField(controller: _phoneController),
            const SizedBox(height: 20),

            AuthTextField(
              hintText: "Password",
              isPassword: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 32),

            _isLoading
                ? const CircularProgressIndicator(color: Color(0XFF2563EB))
                : PrimaryButton(
              text: "Sign up",
              onPressed: _verifyPhone,
            ),

            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(color: Color(0XFF6C757D), fontSize: 16),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      color: Color(0XFF2852A4),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}