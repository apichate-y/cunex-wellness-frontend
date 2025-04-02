import 'package:cunex_wellness/core/controllers/background_controller.dart';
import 'package:cunex_wellness/core/widgets/cached_image.dart';
import 'package:cunex_wellness/core/widgets/custom_appbar.dart';
import 'package:cunex_wellness/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroChatScreen extends StatelessWidget {
  const IntroChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundController = Get.find<BackgroundController>();
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Obx(
            () => CachedImage(
              imagePath: backgroundController.backgroundImage.value,
              fit: BoxFit.cover,
            ),
          ),

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

          // Speech bubble + message
          Positioned(
            top: screenHeight * 0.31,
            left: 10,
            right: 40,
            child: SizedBox(
              height: 125,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    child: CachedImage(
                      imagePath: 'lib/assets/images/element/b.png',
                      fit: BoxFit.contain,
                      height: 120,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: -50,
                    right: 0,
                    child: CachedImage(
                      imagePath: 'lib/assets/images/word/8.png',
                      fit: BoxFit.contain,
                      height: 70,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 40,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.CHAT);
                      },
                      child: CachedImage(
                        imagePath: 'lib/assets/images/word/4.png',
                        height: screenHeight * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Mascot
          Positioned(
            bottom: screenHeight * 0.22,
            left: 0,
            right: 0,
            child: CachedImage(
              imagePath: 'lib/assets/images/mascot/nexky character-06.png',
              height: 300,
            ),
          ),
        ],
      ),
    );
  }
}
