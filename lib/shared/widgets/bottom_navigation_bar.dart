import 'package:flutter/material.dart';
import 'package:evently/core/constants/font_constants.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.favorite, 'label': 'My Events'},
      {'icon': Icons.search, 'label': 'Find'},
      {'icon': Icons.note_alt_rounded, 'label': 'Create'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = index == currentIndex;
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: isSelected
                  ? BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(16),
                    )
                  : null,
              child: Row(
                children: [
                  Icon(
                    items[index]['icon'] as IconData,
                    color: isSelected ? Colors.white : Colors.white70,
                  ),
                  if (isSelected) ...[
                    const SizedBox(width:4 ),
                    Text(
                      items[index]['label'] as String,
                      style: AppFonts.buttonText.copyWith(color: Colors.white),
                    ),
                  ]
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
