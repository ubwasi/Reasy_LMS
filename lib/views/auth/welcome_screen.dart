import 'package:flutter/material.dart';
import 'package:ready_lms/core/services/auth_service.dart';
import 'package:ready_lms/views/auth/login_screen.dart';
import 'package:ready_lms/views/auth/signup_screen.dart';
import 'package:ready_lms/views/auth/widgets/primary_button.dart';
import 'package:ready_lms/views/auth/widgets/social_login_button.dart';

import '../home/main_screens.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final AuthService _authService = AuthService();


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Sign in or Login First")),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9ECFF),
                  borderRadius: BorderRadius.circular(48),
                ),
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF246BFD),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 12,bottom: 75),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                '',
                height: 81.23,
                width: 66.74,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.school, size: 80, color: Color(0xFF246BFD)),
              ),
              const SizedBox(height:56),
              const Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF2C3E50),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Hello there, how would you like to continue",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF5E6470),
                ),
              ),
              const SizedBox(height: 48),
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
              const SizedBox(height: 16),
              SocialLoginButton(
                text: "Continue with Apple",
                iconPath: 'assets/images/apple.png',
                onTap: () {},
              ),
              const SizedBox(height: 24),
              const Text(
                "Or",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF777777)),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: "Log In With Email",
                isEnabled: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
              SizedBox(height: 147),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Color(0xFF6B7280)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder:(context) =>  SignUpScreen()));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xFF246BFD),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}