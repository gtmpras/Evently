
import 'package:evently/core/constants/font_constants.dart';
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String imagePath;
  final String count;
  final String label;
  final Color color;

  const StatCard({
    Key? key,
    required this.imagePath,
    required this.count,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // base color of card
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top colored header
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                height: 35,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Bottom text part
          Text(count, style: AppFonts.heading),
          Text(label, style: AppFonts.subheading),
        ],
      ),
    );
  }
}
