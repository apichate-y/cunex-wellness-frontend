import 'package:cunex_wellness/features/avartar_customizer/views/bot_gender_screen.dart';
import 'package:cunex_wellness/features/calendar/views/calendar_screen.dart';
import 'package:cunex_wellness/features/chat_bot/views/chat_screen.dart';
import 'package:cunex_wellness/features/home/views/home_screen.dart';
import 'package:cunex_wellness/features/landing/views/landing_screen.dart';
import 'package:cunex_wellness/features/music/views/audio_player_screen.dart';
import 'package:cunex_wellness/features/music/views/audio_playlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cunex_wellness/features/splash_screen/views/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder:
          (BuildContext context, GoRouterState state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/botgender',
      name: 'botgender',
      builder:
          (BuildContext context, GoRouterState state) =>
              const BotGenderScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return LandingScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/calendar',
          builder: (context, state) => const CalendarScreen(),
        ),
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/profile',
          builder:
              (context, state) =>
                  Scaffold(body: const Center(child: Text('Profile'),),),
        ),
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
      ],
    ),
    GoRoute(
      path: '/chat',
      name: 'chat',
      builder:
          (BuildContext context, GoRouterState state) => const ChatScreen(),
    ),
  ],
);
