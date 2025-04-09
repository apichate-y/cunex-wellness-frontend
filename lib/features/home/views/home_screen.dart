import 'dart:developer';

import 'package:cunex_wellness/core/services/background_service.dart';
import 'package:cunex_wellness/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider สำหรับหน้า Home
final homeImagesLoadedProvider = StateProvider<bool>((ref) => false);
final homeImageLoaderProvider = FutureProvider.family<void, BuildContext>((
  ref,
  context,
) async {
  try {
    // โหลดรูปภาพที่ใช้ในหน้า Home
    await precacheImage(
      const AssetImage('lib/assets/images/mascot/nexky character-06.png'),
      context,
    );
    // เพิ่มรูปภาพอื่นๆ ที่ใช้ในหน้า Home

    ref.read(homeImagesLoadedProvider.notifier).state = true;
  } catch (e) {
    log('Error loading home images: $e');
    ref.read(homeImagesLoadedProvider.notifier).state = true;
  }
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // เริ่มโหลดรูปภาพทันทีที่สร้าง widget
    Future.microtask(() => ref.read(homeImageLoaderProvider(context)));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bgImage = ref.watch(backgroundImageProvider);
    final imagesLoaded = ref.watch(homeImagesLoadedProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(bgImage, fit: BoxFit.cover),

          // Appbar
          Positioned(
            top: 20,
            left: 0,
            right: 0, // ขยายเต็มจอ
            child: Align(
              alignment: Alignment.topCenter,
              child: CustomAppbar(level: 1, progress: 0.5),
            ),
          ),

          // แสดงตัว loading ถ้ารูปภาพยังไม่โหลดเสร็จ
          if (!imagesLoaded) const Center(child: CircularProgressIndicator()),

          // Speech bubble + message
          // แสดงเนื้อหาเมื่อรูปภาพโหลดเสร็จแล้ว
          if (imagesLoaded) ...[
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

            Positioned(
              top: screenHeight * 0.33,
              left: 60,
              right: 60,
              child: Image.asset(
                'lib/assets/images/word/1.png',
                fit: BoxFit.contain,
                height: screenHeight * 0.06,
              ),
            ),

            // Mascot

            Positioned(
              bottom: screenHeight * 0.22,
              left: 0,
              right: 0,
              child: Image.asset(
                'lib/assets/images/mascot/nexky character-06.png',
                height: screenHeight * 0.35,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
