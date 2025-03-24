import 'dart:async';
import 'package:cunex_wellness/core/enums/day_period.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final backgroundImageProvider = StateNotifierProvider<BackgroundImageNotifier, String>((ref) {
  return BackgroundImageNotifier();
});

class BackgroundImageNotifier extends StateNotifier<String> {
  BackgroundImageNotifier() : super(_getBackgroundForPeriod(getDayPeriod())) {
    Timer.periodic(Duration(minutes: 1), (_) => _checkAndUpdate());
  }

  DayPeriod _lastPeriod = getDayPeriod();

  void _checkAndUpdate() {
    final currentPeriod = getDayPeriod();
    if (currentPeriod != _lastPeriod) {
      _lastPeriod = currentPeriod;
      state = _getBackgroundForPeriod(currentPeriod);
    }
  }

  static String _getBackgroundForPeriod(DayPeriod period) {
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
