import 'dart:developer';

import 'package:cunex_wellness/core/services/background_service.dart';
import 'package:cunex_wellness/core/widgets/optimized_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Provider เฉพาะสำหรับ BotGenderScreen
final botGenderImagesLoadedProvider = StateProvider<bool>((ref) => false);
final botGenderImageLoaderProvider = FutureProvider.family<void, BuildContext>((
  ref,
  context,
) async {
  try {
    await precacheImage(
      const AssetImage('lib/assets/images/element/a.png'),
      context,
    );
    await precacheImage(
      const AssetImage('lib/assets/images/word/2.png'),
      context,
    );
    await precacheImage(
      const AssetImage('lib/assets/images/mascot/nexky character-09.png'),
      context,
    );
    await precacheImage(
      const AssetImage('lib/assets/images/mascot/iconnie.png'),
      context,
    );

    ref.read(botGenderImagesLoadedProvider.notifier).state = true;
  } catch (e) {
    log('Error loading images: $e');
    ref.read(botGenderImagesLoadedProvider.notifier).state = true;
  }
});

class BotGenderScreen extends ConsumerStatefulWidget {
  const BotGenderScreen({super.key});

  @override
  ConsumerState<BotGenderScreen> createState() => _BotGenderScreenState();
}

class _BotGenderScreenState extends ConsumerState<BotGenderScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(botGenderImageLoaderProvider(context)));
  }

  void onMascotTap() {
    try {
      context.go('/home');
    } catch (e) {
      log('Navigation error: $e');
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgImage = ref.watch(backgroundImageProvider);
    final imagesLoaded = ref.watch(botGenderImagesLoadedProvider);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(bgImage, fit: BoxFit.cover),

          // แสดงตัว loading ถ้ารูปภาพยังโหลดไม่เสร็จ
          if (!imagesLoaded) const Center(child: CircularProgressIndicator()),

          if (imagesLoaded) ...[
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
        ],
      ),
    );
  }
}
