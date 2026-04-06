import 'package:flutter/material.dart';
import 'package:ready_lms/views/auth/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/primary_button.dart';
import 'widgets/role_card.dart';
class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;
  bool get _isContinueEnabled => _selectedRole != null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Choose Your Role",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF161C24),
                  ),
                ),
              ),
              const SizedBox(height: 150),

              const Text(
                "Select how you want to use the app",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF000000),
                ),
              ),
              const SizedBox(height: 20),
              RoleCard(
                title: "Student",
                subtitle: "Browse courses, learn new skills",
                icon: Icons.school_outlined,
                isSelected: _selectedRole == 'Student',
                onTap: () {
                  setState(() {
                    _selectedRole = 'Student';
                  });
                },
              ),
              const SizedBox(height: 16),

              RoleCard(
                title: "Instructor",
                subtitle: "Create courses, teach students, and earn",
                icon: Icons.person_add_alt_1_outlined,
                isSelected: _selectedRole == 'Instructor',
                onTap: () {
                  setState(() {
                    _selectedRole = 'Instructor';
                  });
                },
              ),

              SizedBox(height: 150),

              PrimaryButton(
                text: "Continue",
                isEnabled: _isContinueEnabled,
                  onPressed: () async {
                    if (_isContinueEnabled) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('userRole', _selectedRole!);
                      await prefs.setBool('isRoleSelected', true);

                      if (!context.mounted) return;
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
                    }
                  },
              ),
              SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                  },
                  child:  Text(
                    "Decide later",
                    style: TextStyle(
                      fontSize: 16,
                      color: _isContinueEnabled
                          ? Color(0xFF919EAB)
                          : Color(0XFF454F5B),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 56),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF454F5B),
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    TextButton(
                      onPressed: () {

                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF246BFD),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}