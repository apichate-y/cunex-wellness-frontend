import 'package:cunex_wellness/core/services/background_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cunex_wellness/core/enums/bot_gender.dart';
import 'package:cunex_wellness/core/services/preferences_manager.dart';

final botGenderProvider = FutureProvider<BotGender>((ref) async {
  return await PreferencesManager.loadBotGender();
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final bgImage = ref.watch(backgroundImageProvider);
    final gender = ref.watch(botGenderProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🖼️ Background image
          Image.asset(bgImage, fit: BoxFit.cover),

          // 🔊 Top bar (icon, progress, music)
          Positioned(
            top: 48,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/icon/hanger.png', width: 30),
                Image.asset('assets/images/element/progress.png', width: 120),
                Image.asset('assets/images/icon/music.png', width: 30),
              ],
            ),
          ),

          Positioned(
            top: screenHeight * 0.31,
            left: 0,
            right: 80,
            child: SizedBox(
              height: 100, // ปรับตามขนาดกล่อง
              child: Stack(
                children: [
                  // 1. กล่อง bubble
                  Image.asset(
                    'lib/assets/images/element/b.png',
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),

                  // 2. ข้อความหลัก (ตรงกลาง)
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    child: Image.asset(
                      'lib/assets/images/word/3.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  // 3. คำว่า "ต่อไป" (มุมขวาล่าง)
                  Positioned(
                    bottom: 8,
                    right: 16,
                    child: Image.asset(
                      'lib/assets/images/word/4.png',
                      scale: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🔵 Mascot
          Positioned(
            bottom: screenHeight * 0.18,
            left: 0,
            right: 0,
            child: Image.asset(
              gender == BotGender.male
                  ? 'lib/assets/images/mascot/nexky character-10.png'
                  : gender == BotGender.female
                  ? 'lib/assets/images/mascot/nexky character-11.png'
                  : 'lib/assets/images/mascot/nexky character-09.png', // 👈 สำหรับ other
              key: ValueKey(gender),
              height: 300.0,
            ),
          ),

          // 🕒 Bottom nav
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              color: Colors.white.withOpacity(0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/icon/calendar.png', width: 32),
                  Image.asset('assets/images/icon/home_active.png', width: 32),
                  Image.asset('assets/images/icon/moon.png', width: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
