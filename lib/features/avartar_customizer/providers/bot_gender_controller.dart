import 'dart:developer';
import 'package:cunex_wellness/routes/app_pages.dart';
import 'package:get/get.dart';

class BotGenderController extends GetxController {
  final isImagesLoaded = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    // ใช้รูปภาพจาก ImageCacheController ที่โหลดไว้แล้ว
    isImagesLoaded.value = true;
  }
  
  void navigateToHome() {
    try {
      Get.toNamed(Routes.HOME);
    } catch (e) {
      log('Navigation error: $e');
      Get.offNamed(Routes.HOME);
    }
  }
}