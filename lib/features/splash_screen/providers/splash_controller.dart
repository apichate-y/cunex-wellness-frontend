import 'dart:developer';
import 'package:cunex_wellness/core/controllers/image_cache_controller.dart';
import 'package:cunex_wellness/features/avartar_customizer/views/bot_gender_screen.dart';
import 'package:cunex_wellness/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final isImagesLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    waitForImagesAndNavigate();
  }

  Future<void> waitForImagesAndNavigate() async {
    try {
      final imageCacheController = Get.find<ImageCacheController>();

      // รอให้รูปภาพโหลดเสร็จ
      // ever(imageCacheController.isInitialized, (initialized) {
      //   if (initialized) {
      //     isImagesLoaded.value = true;
      //   }
      // });

      // หรือใช้แบบนี้ถ้า ever ไม่ทำงาน
      while (!imageCacheController.isInitialized.value) {
        await Future.delayed(Duration(milliseconds: 100));
      }
      isImagesLoaded.value = true;
    } catch (e) {
      log('Error waiting for images: $e');
      isImagesLoaded.value = true;
    }
  }

  void navigateToBotGender() {
    try {
      Get.toNamed(Routes.BOT_GENDER);
    } catch (e) {
      log('Navigation error: $e');
      // ถ้า GetX ไม่ทำงาน ลองใช้ Navigator
      Get.to(() => const BotGenderScreen());
    }
  }
}
