import 'package:flutter/material.dart';
import 'package:ready_lms/views/auth/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/onboardin_view_model/onboarding_model.dart';
import '../auth/role_selection_screen.dart';
class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  List<OnboardingModel> contents = [
    OnboardingModel(
      image: 'assets/images/oneBoading1.png',
      title: 'Discover Top Courses',
      description: 'Explore thousands of courses from expert instructors',
    ),
    OnboardingModel(
      image: 'assets/images/oneBoading2.jpg',
      title: 'Learn Anytime, Anywhere',
      description: 'Access lessons on your schedule and track your progress',
    ),
    OnboardingModel(
      image: 'assets/images/oneBoading3.png',
      title: 'Teach & Share Your Knowledge',
      description: 'Create courses, reach students, and earn from your expertise',
    ),
  ];

  void goToHome() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isOnboardingDone', true);

    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const RoleSelectionScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: goToHome,
                child: Text("Skip", style: TextStyle(color: Colors.blue)),
              ),
            ),
          ),

          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          contents[i].image,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        contents[i].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      SizedBox(height: 24),
                      Text(
                        contents[i].description,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 112, horizontal: 16),
            child: SizedBox(
              height: 50,
              child: Stack(
                children: [

                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        contents.length,
                            (index) => buildDot(index),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF153885),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward, color: Colors.white),
                        onPressed: () {
                          if (_currentIndex == contents.length - 1) {
                            goToHome();
                          }
                          else {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                      ),
                    )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 9,
      width: _currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _currentIndex == index
            ? Colors.blue
            : Colors.blue.withOpacity(0.3),
      ),
    );
  }
}