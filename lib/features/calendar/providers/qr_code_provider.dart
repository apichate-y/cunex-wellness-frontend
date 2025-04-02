import 'package:get/get.dart';

class QrScanController extends GetxController {
  // ใช้ Rx<String?> แทน String? ใน StateNotifier
  final qrCode = Rx<String?>(null);
  
  // เมธอดเทียบเท่ากับใน QRCodeState
  void setCode(String code) => qrCode.value = code;
  void clear() => qrCode.value = null;
}