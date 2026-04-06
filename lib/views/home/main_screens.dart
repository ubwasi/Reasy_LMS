import 'package:flutter/material.dart';
import '../auth/widgets/course_card.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({super.key});

  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        leading: const Padding(
          padding: EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://randomuser.me/api/portraits/women/44.jpg"),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Hello, Fahmida",
                style: TextStyle(
                    color: Color(0XFF5A5C5F),
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),

            Text("Browse or search your courses.",
                style: TextStyle(color: Color(0XFF5A5C5F),fontSize: 12)),
          ],
        ),
        actions: [
          Icon(Icons.shopping_cart_outlined, color: Colors.black),
          SizedBox(width: 10),
          Stack(
            children: [
              Icon(Icons.notifications_none, color: Colors.black),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
          SizedBox(width: 16)
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0XFF03005333).withOpacity(0.2)
                      )
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                        icon: Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.tune, color: Color(0xFF8993A4),size: 48,),
                )
              ],
            ),

            const SizedBox(height: 22),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8E63F7), Color(0xFF6C4DF6)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text("Discounted Courses",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                      SizedBox(height: 4),
                        const Text(
                          "Discount 50% for the first purchases.",
                          style:
                          TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2563EB),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text("Purchase Now",
                              style: TextStyle(color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                  Image.network(
                    "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                    height: 90,
                  )
                ],
              ),
            ),

            const SizedBox(height: 22),

            const Text("Top Rated Courses",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),

            const SizedBox(height: 10),

            _buildCategoryList(),

            const SizedBox(height: 10),

            const CourseCard(),
            const CourseCard(),

            const SizedBox(height: 10),

            const Text("Show More",
                style: TextStyle(color: Color(0xFF246BFD))),

            const SizedBox(height: 20),

            const Text("Free Courses",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            _buildCategoryList(),

            const CourseCard(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: const Color(0xFF246BFD),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle), label: "Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Instructors"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Activities"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    List<String> list = ["All", "UX Design", "Python", "Mobile"];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list.map((e) {
          bool selected = e == "UX Design";
          return Container(
            margin: const EdgeInsets.only(right: 12),
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFF246BFD)
                  : const Color(0xFFF1F3F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(e,
                style: TextStyle(
                    color: selected ? Colors.white : Colors.black54)),
          );
        }).toList(),
      ),
    );
  }
}