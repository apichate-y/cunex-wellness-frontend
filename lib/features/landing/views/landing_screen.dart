import 'package:cunex_wellness/core/providers/navigation_provider.dart';
import 'package:cunex_wellness/core/widgets/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LandingScreen extends ConsumerWidget {
  final Widget child;

  const LandingScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
      body: Stack(
        children: [
          child, // 👈 child ถูก inject เข้ามาจาก GoRouter
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomNavigationBar(
              selectedIndex: selectedIndex,
              onTap: (index) {
                final paths = [
                  '/calendar',
                  '/chat',
                  '/home',
                  '/playlist',
                  '/profile',
                ];
                ref.read(selectedIndexProvider.notifier).state = index;
                context.go(paths[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
