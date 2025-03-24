import 'package:cunex_wellness/core/enums/bot_gender.dart';
import 'package:cunex_wellness/core/services/background_service.dart';
import 'package:cunex_wellness/core/providers/bot_gender_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BotGenderScreen extends ConsumerStatefulWidget {
  const BotGenderScreen({super.key});

  @override
  ConsumerState<BotGenderScreen> createState() => _BotGenderScreenState();
}

class _BotGenderScreenState extends ConsumerState<BotGenderScreen> {
  bool isPressed = false;

  void onMascotTap() async {
    setState(() {
      isPressed = true;
    });

    await Future.delayed(const Duration(milliseconds: 300));

    if (!mounted) return;

    // ถ้าเคยเลือกแล้ว → ไปหน้า home ทันที
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final bgImage = ref.watch(backgroundImageProvider);
    final gender = ref.watch(botGenderProvider);

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🖼️ Background image
          Image.asset(bgImage, fit: BoxFit.cover),

          // 🗨️ Speech bubble image
          Positioned(
            top: screenHeight * 0.31,
            left: 40,
            right: 40,
            child: Image.asset(
              'lib/assets/images/element/a.png',
              fit: BoxFit.contain,
            ),
          ),

          // 📝 Text image inside bubble
          Positioned(
            top: screenHeight * 0.34,
            left: 60,
            right: 60,
            child: Image.asset(
              'lib/assets/images/word/2.png',
              fit: BoxFit.contain,
            ),
          ),

          // 🐣 Mascot image with glow effect when tapped
          Positioned(
            bottom: screenHeight * 0.22,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: onMascotTap,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Container(
                  key: ValueKey(isPressed),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    boxShadow:
                        isPressed
                            ? [
                              BoxShadow(
                                color: Colors.yellowAccent.withValues(
                                  alpha: 0.4,
                                ), //
                                blurRadius: 20,
                                spreadRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ]
                            : [],
                  ),
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
              ),
            ),
          ),

          // 👚 Gender Options
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 🚺 Female
                GestureDetector(
                  onTap: () async {
                    await ref
                        .read(botGenderProvider.notifier)
                        .selectGender(BotGender.female);
                  },
                  child: Container(
                    width: 90,
                    height: 90,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'lib/assets/images/แต่งตัวnexky/nexky character-04.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // 🚹 Male
                GestureDetector(
                  onTap: () async {
                    await ref
                        .read(botGenderProvider.notifier)
                        .selectGender(BotGender.male);
                  },
                  child: Container(
                    width: 90,
                    height: 90,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'lib/assets/images/แต่งตัวnexky/nexky character-05.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
