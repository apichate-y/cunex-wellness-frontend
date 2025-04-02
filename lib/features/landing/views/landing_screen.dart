import 'package:cunex_wellness/core/widgets/custom_navigation.dart';
import 'package:cunex_wellness/features/calendar/views/calendar_screen.dart';
import 'package:cunex_wellness/features/chat_bot/views/chat_screen.dart';
import 'package:cunex_wellness/features/home/views/home_screen.dart';
import 'package:cunex_wellness/features/landing/providers/navigation_controller.dart';
import 'package:cunex_wellness/features/music/views/audio_playlist_screen.dart';
import 'package:cunex_wellness/features/profile/views/personal_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.find<NavigationController>();

    return Scaffold(
      body: Stack(
        children: [
          // ใช้ AnimatedSwitcher เพื่อให้มี transition
          Obx(() {
            final currentIndex = navigationController.selectedIndex.value;
            Widget currentScreen;

            // เลือกหน้าตาม index
            switch (currentIndex) {
              case 0:
                currentScreen = const CalendarScreen();
                break;
              case 1:
                currentScreen = const ChatScreen();
                break;
              case 2:
                currentScreen = const HomeScreen();
                break;
              case 3:
                currentScreen = const AudioPlaylistScreen();
                break;
              case 4:
                currentScreen = const PersonalInfoScreen();
                break;
              default:
                currentScreen = const HomeScreen();
            }

            // กำหนด key เพื่อให้ AnimatedSwitcher รู้ว่ามีการเปลี่ยนแปลง widget
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                // Slide transition จากขวาไปซ้าย
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
              child: KeyedSubtree(
                key: ValueKey<int>(currentIndex),
                child: currentScreen,
              ),
            );
          }),

          // Navigation Bar ยังคงอยู่และไม่มีการ transition
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Obx(
              () => CustomNavigationBar(
                selectedIndex: navigationController.selectedIndex.value,
                onTap: (index) {
                  // เปลี่ยนเฉพาะ index ไม่ต้องใช้ navigation
                  navigationController.changeIndex(index);

                  // อัพเดทพาธใน URL (ถ้าต้องการ)
                  final paths = [
                    '/calendar',
                    '/chat',
                    '/home',
                    '/playlist',
                    '/profile',
                  ];
                  Get.toNamed(paths[index], preventDuplicates: false);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
