import 'package:cunex_wellness/config/color.dart';
import 'package:cunex_wellness/core/services/background_service.dart';
import 'package:cunex_wellness/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cunex_wellness/core/enums/bot_gender.dart';
import 'package:cunex_wellness/core/services/preferences_manager.dart';
import 'package:go_router/go_router.dart';

final botGenderProvider = FutureProvider<BotGender>((ref) async {
  return await PreferencesManager.loadBotGender();
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;

    final bgImage = ref.watch(backgroundImageProvider);
    final genderAsync = ref.watch(botGenderProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(bgImage, fit: BoxFit.cover),

          // Appbar
          Positioned(top: 0, child: CustomAppbar()),

          // Logo + Music button
          Positioned(
            top: screenHeight * 0.11,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'lib/assets/images/icons/Untitled-24-01.png',
                  fit: BoxFit.cover,
                  height: 75,
                ),
                GestureDetector(
                  onTap: () {
                    context.push('/playlist'); // สำหรับ GoRouter
                  },
                  child: Image.asset(
                    'lib/assets/images/icons/5 main buttons/music2.png',
                    fit: BoxFit.contain,
                    color: AppTheme.rosePink,
                    height: 35,
                  ),
                ),
              ],
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
                    child: Image.asset(
                      'lib/assets/images/element/b.png',
                      fit: BoxFit.contain,
                      height: 120,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: -50,
                    right: 0,
                    child: Image.asset(
                      'lib/assets/images/word/3.png',
                      fit: BoxFit.contain,
                      height: 50,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 40,
                    child: GestureDetector(
                      onTap: () {
                        context.push('/chat'); // สำหรับ GoRouter
                      },
                      child: Image.asset(
                        'lib/assets/images/word/4.png',
                        scale: 9,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Mascot
          Positioned(
            bottom: screenHeight * 0.18,
            left: 0,
            right: 0,
            child: genderAsync.when(
              data:
                  (gender) => Image.asset(
                    gender == BotGender.male
                        ? 'lib/assets/images/mascot/nexky character-10.png'
                        : gender == BotGender.female
                        ? 'lib/assets/images/mascot/nexky character-11.png'
                        : 'lib/assets/images/mascot/nexky character-09.png',
                    height: 300,
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
