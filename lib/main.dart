import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ready_lms/views/auth/success_screen.dart';
import 'package:ready_lms/views/splash/splash_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreens(),
    );
  }
}