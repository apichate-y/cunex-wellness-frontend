import 'package:get/get.dart';

class HomeController extends GetxController {
  final isImagesLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    // ตั้งค่าเริ่มต้น - รูปภาพถูกโหลดไว้ใน ImageCacheController แล้ว
    isImagesLoaded.value = true;
  }
}
