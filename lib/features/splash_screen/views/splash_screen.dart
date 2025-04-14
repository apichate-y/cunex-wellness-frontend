import 'dart:developer';

import 'package:cunex_wellness/core/services/background_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

// Provider สำหรับติดตามสถานะการโหลดรูปภาพ
final imagesLoadedProvider = StateProvider<bool>((ref) => false);

// Provider สำหรับติดตามสถานะการอนุญาตกล้อง
final cameraPermissionProvider =
    StateProvider<PermissionStatus?>((ref) => null);

// Provider สำหรับการโหลดรูปภาพ
final imageLoaderProvider = FutureProvider.family<void, BuildContext>((
  ref,
  context,
) async {
  try {
    // โหลดรูปภาพทีละรูป
    await precacheImage(
      const AssetImage('lib/assets/images/element/a.png'),
      context,
    );
    await precacheImage(
      const AssetImage('lib/assets/images/word/1.png'),
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

    // เมื่อโหลดเสร็จให้อัพเดท state
    ref.read(imagesLoadedProvider.notifier).state = true;
  } catch (e) {
    log('Error loading images: $e');
    // กรณีเกิดข้อผิดพลาดให้ถือว่าโหลดเสร็จแล้ว
    ref.read(imagesLoadedProvider.notifier).state = true;
  }
});

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // เริ่มโหลดรูปภาพเมื่อ widget ถูกสร้าง
    Future.microtask(() {
      ref.read(imageLoaderProvider(context));
      checkCameraPermission();
    });
  }

  // ฟังก์ชันเช็คและขอสิทธิ์กล้อง
  Future<void> checkCameraPermission() async {
    try {
      // เช็คสถานะสิทธิ์ปัจจุบัน
      final status = await Permission.camera.status;

      // อัพเดทสถานะใน provider
      ref.read(cameraPermissionProvider.notifier).state = status;

      // ถ้ายังไม่ได้รับอนุญาต ให้ขอสิทธิ์
      if (!status.isGranted) {
        final result = await Permission.camera.request();
        ref.read(cameraPermissionProvider.notifier).state = result;

        log('Camera permission request result: $result');
      }
    } catch (e) {
      log('Error checking camera permission: $e');
    }
  }

  void onMascotTap() {
    try {
      // ใช้ try-catch สำหรับการนำทาง
      context.go('/botgender');
    } catch (e) {
      log('Navigation error: $e');
      // Fallback สำหรับ iOS Safari
      Navigator.of(context).pushReplacementNamed('/botgender');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgImage = ref.watch(backgroundImageProvider);
    final imagesLoaded = ref.watch(imagesLoadedProvider);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(bgImage, fit: BoxFit.cover),

          // แสดงตัว loading ถ้ารูปภาพยังโหลดไม่เสร็จ
          if (!imagesLoaded) const Center(child: CircularProgressIndicator()),

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
