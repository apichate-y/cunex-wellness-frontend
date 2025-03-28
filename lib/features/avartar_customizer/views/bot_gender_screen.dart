import 'package:cunex_wellness/core/services/background_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BotGenderScreen extends ConsumerStatefulWidget {
  const BotGenderScreen({super.key});

  @override
  ConsumerState<BotGenderScreen> createState() => _BotGenderScreenState();
}

class _BotGenderScreenState extends ConsumerState<BotGenderScreen> {
  void onMascotTap() async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (!mounted) return;

    // ถ้าเคยเลือกแล้ว → ไปหน้า home ทันที
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final bgImage = ref.watch(backgroundImageProvider);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(bgImage, fit: BoxFit.cover),

          // Speech bubble image
          Positioned(
            top: screenHeight * 0.29,
            left: 40,
            right: 40,
            child: Image.asset(
              'lib/assets/images/element/a.png',
              fit: BoxFit.contain,
              height: screenHeight * 0.13,
            ),
          ),

          // Text image inside bubble
          Positioned(
            top: screenHeight * 0.33,
            left: 60,
            right: 60,
            child: Image.asset(
              'lib/assets/images/word/2.png',
              fit: BoxFit.contain,
              height: screenHeight * 0.06,
            ),
          ),

          // Mascot image with glow effect when tapped
          Positioned(
            bottom: screenHeight * 0.22,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: onMascotTap,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Image.asset(
                  'lib/assets/images/mascot/nexky character-09.png',
                  height: screenHeight * 0.35,
                ),
              ),
            ),
          ),

          Positioned(
            bottom: screenHeight * 0.16,
            left: 60,
            right: 60,
            child: Image.asset(
              'lib/assets/images/mascot/iconnie.png',
              fit: BoxFit.contain,
              height: screenHeight * 0.12,
            ),
          ),
        ],
      ),
    );
  }
}
