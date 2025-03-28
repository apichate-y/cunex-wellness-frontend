import 'package:cunex_wellness/config/color.dart';
import 'package:cunex_wellness/features/music/views/audio_playlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryFilterButton extends ConsumerWidget {
  final String? category;
  final String label;

  const CategoryFilterButton({super.key, required this.category, required this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedCategoryProvider);
    category == selected || (category == null && selected == null);

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
        onTap: () => ref.read(selectedCategoryProvider.notifier).state = category,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(getIcon(category), color: AppTheme.rosePink, size: 32),
            ),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: AppTheme.white)),
          ],
        ),
      ),
    );
  }
}