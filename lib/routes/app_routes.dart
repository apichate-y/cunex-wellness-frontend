import 'dart:developer';

import 'package:cunex_wellness/core/providers/navigator_key_provider.dart';
import 'package:cunex_wellness/features/avartar_customizer/views/bot_gender_screen.dart';
import 'package:cunex_wellness/features/calendar/views/calendar_screen.dart';
import 'package:cunex_wellness/features/calendar/views/qr_scan_screen.dart';
import 'package:cunex_wellness/features/chat_bot/views/chat_screen.dart';
import 'package:cunex_wellness/features/home/views/home_screen.dart';
import 'package:cunex_wellness/features/landing/views/landing_screen.dart';
import 'package:cunex_wellness/features/music/views/audio_player_screen.dart';
import 'package:cunex_wellness/features/music/views/audio_playlist_screen.dart';
import 'package:cunex_wellness/features/profile/views/personal_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cunex_wellness/features/splash_screen/views/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final navigatorKey = ref.watch(navigatorKeyProvider);

  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routerNeglect: true,
    redirect: (context, state) {
      try {
        if (state.path =='/'){
          return null;
        }
      } catch (e) {
        log('Redirect error: $e');
      }
      return null;
    },
    errorBuilder: (context, state) {
      log('GoRouter error: ${state.error}');
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('เกิดข้อผิดพลาดในการนำทาง'),
              ElevatedButton(
                onPressed: () => context.go('/home'),
                child: const Text('กลับสู่หน้าหลัก'),
              ),
            ],
          ),
        ),
      );
    },
    routes: [
      // Splash Screen เป็นจุดเริ่มต้น
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // เป็นหน้าถัดไปหลัง Splash
      GoRoute(
        path: '/botgender',
        name: 'botgender',
        builder: (context, state) => const BotGenderScreen(),
      ),

      // Shell Route สำหรับหน้าที่มี Navigation Bar
      ShellRoute(
        builder: (context, state, child) => LandingScreen(child: child),
        routes: [
          // GoRoute(
          //   path: '/intro-calendar',
          //   builder: (context, state) => const IntroCalendarScreen(),
          // ),
          GoRoute(
            path: '/calendar',
            builder: (context, state) => const CalendarScreen(),
          ),
          GoRoute(
            path: '/qr-scan',
            builder: (context, state) => const QrScanScreen(),
          ),
          // GoRoute(
          //   path: '/intro-chat',
          //   builder: (context, state) => const IntroChatScreen(),
          // ),
          GoRoute(
            path: '/chat',
            name: 'chat',
            builder: (context, state) => const ChatScreen(),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          // GoRoute(
          //   path: '/intro-audio',
          //   builder: (context, state) => const IntroAudioScreen(),
          // ),
          GoRoute(
            path: '/playlist',
            builder: (context, state) => const AudioPlaylistScreen(),
          ),
          GoRoute(
            path: '/player',
            builder: (context, state) {
              final extra = Map<String, String>.from(state.extra as Map);
              return AudioPlayerScreen(
                title: extra['title']!,
                category: extra['category']!,
                path: extra['path']!,
              );
            },
          ),
          // GoRoute(
          //   path: '/intro-profile',
          //   builder: (context, state) => IntroPersonalInfoScreen(),
          // ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => PersonalInfoScreen(),
          ),
        ],
      ),
    ],
  );
});
