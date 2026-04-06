import 'package:flutter/material.dart';
import 'package:ready_lms/core/services/auth_service.dart';
import 'package:ready_lms/views/auth/signup_screen.dart';
import 'package:ready_lms/views/auth/widgets/no_account_dialog.dart';
import 'package:ready_lms/views/auth/widgets/primary_button.dart';
import '../home/main_screens.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/social_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  String? _emailError;
  String? _passwordError;

  void _showNoAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFFD9ECFF),
              radius: 30,
              child: Icon(Icons.person_outline, size: 30, color: Color(0xFF246BFD)),
            ),
            const SizedBox(height: 16),
            const Text(
              "Sorry, there is no account with this email.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            const Text("Create an account to continue", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Back"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF246BFD)),
                    onPressed: () {

                    },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text("Welcome Back!", style: TextStyle(fontSize: 24, color: Color(0XFF2C3E50), fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            const Text("Hello there, login with your information", style: TextStyle(fontSize: 14, color: Color(0XFF5E6470))),
            const SizedBox(height: 40),
            AuthTextField(
              hintText: "Enter email address",
              controller: _emailController,
              errorText: _emailError,
            ),
            const SizedBox(height: 16),

            AuthTextField(
              hintText: "Password",
              isPassword: true,
              controller: _passwordController,
              errorText: _passwordError,
            ),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text("Forgot password?", style: TextStyle(fontSize: 14, color: Color(0xFF6C757D))),
              ),
            ),
            const SizedBox(height: 64),

            PrimaryButton(
              text: "Log In",
              onPressed: () async {
                setState(() { _emailError = null; _passwordError = null; });

                final user = await _authService.loginWithEmail(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );

                if (user != null) {
                  if (!mounted) return;
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreens()));
                } else {
                  setState(() {
                    _passwordError = "The password you've entered is incorrect.";
                  });
                  NoAccountDialog();
                }
              },
            ),
            const SizedBox(height: 16),
            SocialLoginButton(
              text: "Continue with Google",
              iconPath: 'assets/images/google.png',
              onTap: () async {

                final user = await _authService.signInWithGoogle();

                if (user != null) {
                  if (!context.mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreens()),
                  );
                } else {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Google login failed!")),
                  );
                }
              },
            ),
            const SizedBox(height: 96),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?", style: TextStyle(color: Color(0XFF6C757D), fontSize: 16)),
                TextButton(onPressed: () {

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));

                }, child: const Text("Sign Up", style: TextStyle(color: Color(0XFF2852A4), fontSize: 16))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}