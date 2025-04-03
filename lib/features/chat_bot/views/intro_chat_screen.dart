import 'package:cunex_wellness/core/services/background_service.dart';
import 'package:cunex_wellness/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class IntroChatScreen extends ConsumerWidget {
  const IntroChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;

    final bgImage = ref.watch(backgroundImageProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(bgImage, fit: BoxFit.cover),

          // Appbar
          Positioned(
            top: 20,
            left: 0,
            right: 0, // ขยายเต็มจอ
            child: Align(
              alignment: Alignment.topCenter,
              child: CustomAppbar(level: 1, progress: 0.5),
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
                      'lib/assets/images/word/8.png',
                      fit: BoxFit.contain,
                      height: 70,
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
            bottom: screenHeight * 0.22,
            left: 0,
            right: 0,
            child: Image.asset(
              'lib/assets/images/mascot/nexky character-06.png',
              height: 300,
            ),
          ),
        ],
      ),
    );
  }
}
