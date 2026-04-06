import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            child: Image.network(
              "https://images.unsplash.com/photo-1559027615-cd4628902d4a",
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Design | Sophia Khan",
                  style: TextStyle(
                      color: Color(0xFF246BFD), fontSize: 12)),
              Text("24 hrs",
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),

          const SizedBox(height: 4),

          const Text("UX Design for Businesses",
              style:
              TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

          const SizedBox(height: 4),

          Row(
            children: const [
              Text("\$20.00",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              Spacer(),
              Icon(Icons.star, color: Colors.amber, size: 16),
              Text(" 4.5",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(" (450 reviews)",
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}