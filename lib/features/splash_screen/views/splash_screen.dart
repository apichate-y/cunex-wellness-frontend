import 'package:cunex_wellness/core/enums/bot_gender.dart';
import 'package:cunex_wellness/core/providers/assets_precache_provider.dart';
import 'package:cunex_wellness/core/services/background_service.dart';
import 'package:cunex_wellness/core/services/preferences_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final botGenderProvider = FutureProvider<BotGender>((ref) async {
  return await PreferencesManager.loadBotGender();
});

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {


@override
  void initState() {
    super.initState();
    
    Future.microtask(() => ref.read(assetsPrecacheProvider));
  }

  void onMascotTap() async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (!mounted) return;
    context.go('/botgender');
  }

  @override
  Widget build(BuildContext context) {
    final bgImage = ref.watch(backgroundImageProvider);

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(bgImage, fit: BoxFit.cover),

          Positioned(
            top: screenHeight * 0.29,
            left: 40,
            right: 40,
            child: Image.asset(
              'lib/assets/images/element/a.png',
              fit: BoxFit.contain,
              height: screenHeight * 0.13,
            ),
          ),

          Positioned(
            top: screenHeight * 0.33,
            left: 60,
            right: 60,
            child: Image.asset(
              'lib/assets/images/word/1.png',
              fit: BoxFit.contain,
              height: screenHeight * 0.06,
            ),
          ),
          

          Positioned(
            bottom: screenHeight * 0.22,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: onMascotTap,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Image.asset(
                  'lib/assets/images/mascot/nexky character-09.png',
                  height: screenHeight * 0.35,
                ),
              ),
            ),
          ),

          Positioned(
            bottom: screenHeight * 0.16,
            left: 60,
            right: 60,
            child: Image.asset(
              'lib/assets/images/mascot/iconnie.png',
              fit: BoxFit.contain,
              height: screenHeight * 0.12,
            ),
          ),
        ],
      ),
    );
  }
}
