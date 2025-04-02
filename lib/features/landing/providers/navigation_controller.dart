import 'package:get/get.dart';

class NavigationController extends GetxController {
  // เริ่มต้นที่ home (index = 2)
  final selectedIndex = 2.obs;

  void changeIndex(int index) {
    if (index != selectedIndex.value) {
      selectedIndex.value = index;
    }
  }

  // อัพเดทจาก URL path (สำหรับลิงก์โดยตรงหรือการกดกลับ)
  void updateIndexFromPath(String path) {
    if (path.startsWith('/calendar'))
      selectedIndex.value = 0;
    else if (path.startsWith('/chat'))
      selectedIndex.value = 1;
    else if (path.startsWith('/home'))
      selectedIndex.value = 2;
    else if (path.startsWith('/playlist'))
      selectedIndex.value = 3;
    else if (path.startsWith('/profile'))
      selectedIndex.value = 4;
  }
}
