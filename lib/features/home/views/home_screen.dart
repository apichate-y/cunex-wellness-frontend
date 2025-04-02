import 'package:cunex_wellness/core/controllers/background_controller.dart';
import 'package:cunex_wellness/core/widgets/cached_image.dart';
import 'package:cunex_wellness/core/widgets/custom_appbar.dart';
import 'package:cunex_wellness/features/home/providers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ใช้ GetX Controller
    final controller = Get.find<HomeController>();
    final backgroundController = Get.find<BackgroundController>();
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image ใช้ CachedImage แทน Image.asset
          Obx(() => CachedImage(
            imagePath: backgroundController.backgroundImage.value,
            fit: BoxFit.cover,
          )),

          // Appbar
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: CustomAppbar(level: 1, progress: 0.5),
            ),
          ),

          // Loading indicator
          Obx(() => !controller.isImagesLoaded.value 
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox.shrink()),

          // Speech bubble + message (เป็น comment ไว้ตามต้นฉบับ)
          // Positioned(
          //   top: screenHeight * 0.31,
          //   left: 10,
          //   right: 40,
          //   child: SizedBox(
          //     height: 125,
          //     child: Stack(
          //       children: [
          //         Positioned(
          //           left: 0,
          //           child: CachedImage(
          //             imagePath: 'lib/assets/images/element/b.png',
          //             fit: BoxFit.contain,
          //             height: 120,
          //           ),
          //         ),
          //         Positioned(
          //           top: 20,
          //           left: -50,
          //           right: 0,
          //           child: CachedImage(
          //             imagePath: 'lib/assets/images/word/3.png',
          //             fit: BoxFit.contain,
          //             height: 50,
          //           ),
          //         ),
          //         Positioned(
          //           bottom: 8,
          //           right: 40,
          //           child: CachedImage(
          //             imagePath: 'lib/assets/images/word/4.png',
          //             height: 20,
          //             width: 20,
          //             onTap: () => Get.toNamed('/chat'),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          // Mascot
          Obx(() => controller.isImagesLoaded.value 
            ? Positioned(
                bottom: screenHeight * 0.22,
                left: 0,
                right: 0,
                child: CachedImage(
                  imagePath: 'lib/assets/images/mascot/nexky character-06.png',
                  height: screenHeight * 0.35,
                ),
              )
            : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}