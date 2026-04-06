import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ready_lms/views/home/main_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/theme/apps_theme.dart';
import '../auth/login_screen.dart';
import '../auth/role_selection_screen.dart';
import '../auth/welcome_screen.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    bool isOnboardingDone = prefs.getBool('isOnboardingDone') ?? false;
    bool isRoleSelected = prefs.getBool('isRoleSelected') ?? false;
    final currentUser = FirebaseAuth.instance.currentUser;

    if (!isOnboardingDone) {
      _navigate(OnboardingScreen());
    } else if (!isRoleSelected) {
      _navigate(const RoleSelectionScreen());
    } else if (currentUser == null) {
      _navigate(const WelcomeScreen());
    } else {
      _navigate(const MainScreens());
    }
  }

  void _navigate(Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppsTheme.splashGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Ready LMS",
                style: TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "Where Learning Meets Growth",
                style: TextStyle(
                  fontFamily: 'inter',
                  color: Color(0xFFFFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}