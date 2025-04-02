import 'dart:async';
import 'package:get/get.dart';
import 'package:cunex_wellness/core/enums/day_period.dart';

class BackgroundController extends GetxController {
  // ใช้ Rx แทน StateNotifier
  final backgroundImage = ''.obs;
  DayPeriod _lastPeriod = getDayPeriod();
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    // ตั้งค่าเริ่มต้น
    backgroundImage.value = _getBackgroundForPeriod(getDayPeriod());

    // ตั้ง Timer เพื่อตรวจสอบและอัพเดตเป็นระยะ
    _timer = Timer.periodic(Duration(minutes: 1), (_) => _checkAndUpdate());
  }

  // เมื่อ controller ถูกทำลาย ให้ยกเลิก timer
  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _checkAndUpdate() {
    final currentPeriod = getDayPeriod();
    if (currentPeriod != _lastPeriod) {
      _lastPeriod = currentPeriod;
      backgroundImage.value = _getBackgroundForPeriod(currentPeriod);
    }
  }

  String _getBackgroundForPeriod(DayPeriod period) {
    switch (period) {
      case DayPeriod.earlyMorning:
        return 'lib/assets/images/bg/bg_early_morning.png';
      case DayPeriod.noon:
        return 'lib/assets/images/bg/bg_noon.png';
      case DayPeriod.evening:
        return 'lib/assets/images/bg/bg_evening.png';
      case DayPeriod.night:
        return 'lib/assets/images/bg/bg_night.png';
    }
  }
}
