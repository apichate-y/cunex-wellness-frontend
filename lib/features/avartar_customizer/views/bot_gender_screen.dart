
import 'package:cunex_wellness/core/controllers/background_controller.dart';
import 'package:cunex_wellness/core/widgets/cached_image.dart';
import 'package:cunex_wellness/features/avartar_customizer/providers/bot_gender_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BotGenderScreen extends StatelessWidget {
  const BotGenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ใช้ GetX Controller แทน Riverpod
    final controller = Get.find<BotGenderController>();
    final backgroundController = Get.find<BackgroundController>();
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Obx(() => CachedImage(
            imagePath: backgroundController.backgroundImage.value,
            fit: BoxFit.cover,
          )),

          // Loading Indicator
          Obx(() => !controller.isImagesLoaded.value 
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox.shrink()),

          // Content
          Obx(() => controller.isImagesLoaded.value 
            ? Stack(children: [
                // Speech bubble
                Positioned(
                  top: screenHeight * 0.29,
                  left: 40,
                  right: 40,
                  child: CachedImage(
                    imagePath: 'lib/assets/images/element/a.png',
                    height: screenHeight * 0.13,
                    fit: BoxFit.contain,
                  ),
                ),

                // Text inside bubble
                Positioned(
                  top: screenHeight * 0.33,
                  left: 60,
                  right: 60,
                  child: CachedImage(
                    imagePath: 'lib/assets/images/word/2.png',
                    height: screenHeight * 0.06,
                    fit: BoxFit.contain,
                  ),
                ),

                // Mascot with tap gesture
                Positioned(
                  bottom: screenHeight * 0.22,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => controller.navigateToHome(),
                    child: CachedImage(
                      imagePath: 'lib/assets/images/mascot/nexky character-09.png',
                      height: screenHeight * 0.35,
                    ),
                  ),
                ),

                // Logo
                Positioned(
                  bottom: screenHeight * 0.16,
                  left: 60,
                  right: 60,
                  child: CachedImage(
                    imagePath: 'lib/assets/images/mascot/iconnie.png',
                    height: screenHeight * 0.12,
                    fit: BoxFit.contain,
                  ),
                ),
              ])
            : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}