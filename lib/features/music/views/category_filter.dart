import 'package:cunex_wellness/config/color.dart';
import 'package:flutter/material.dart';

class CategoryFilterButton extends StatelessWidget {
  final String? category;
  final String label;

  const CategoryFilterButton({
    super.key, 
    required this.category, 
    required this.label,
    this.isSelected = false,
    required this.onTap,
  });
  
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    IconData getIcon(String? cat) {
      switch (cat) {
        case 'Sleep':
          return Icons.bed;
        case 'Focus':
          return Icons.self_improvement;
        case 'Wellness':
          return Icons.spa;
        case 'Chill':
          return Icons.water;
        default:
          return Icons.library_music;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.rosePink : Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                getIcon(category), 
                color: isSelected ? Colors.white : AppTheme.rosePink, 
                size: 32
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label, 
              style: const TextStyle(color: AppTheme.white)
            ),
          ],
        ),
      ),
    );
  }
}