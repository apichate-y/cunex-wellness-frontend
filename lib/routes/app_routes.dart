import 'package:cunex_wellness/core/providers/navigator_key_provider.dart';
import 'package:cunex_wellness/features/avartar_customizer/views/bot_gender_screen.dart';
import 'package:cunex_wellness/features/calendar/views/calendar_screen.dart';
import 'package:cunex_wellness/features/calendar/views/intro_calendar_screen.dart';
import 'package:cunex_wellness/features/calendar/views/qr_scan_screen.dart';
import 'package:cunex_wellness/features/chat_bot/views/chat_screen.dart';
import 'package:cunex_wellness/features/chat_bot/views/intro_chat_screen.dart';
import 'package:cunex_wellness/features/home/views/home_screen.dart';
import 'package:cunex_wellness/features/landing/views/landing_screen.dart';
import 'package:cunex_wellness/features/music/views/audio_player_screen.dart';
import 'package:cunex_wellness/features/music/views/audio_playlist_screen.dart';
import 'package:cunex_wellness/features/music/views/intro_audio_screen.dart';
import 'package:cunex_wellness/features/profile/views/intro_personal_info_screen.dart';
import 'package:cunex_wellness/features/profile/views/personal_info_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cunex_wellness/features/splash_screen/views/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final navigatorKey = ref.watch(navigatorKeyProvider);

  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/botgender',
        name: 'botgender',
        builder: (context, state) => const BotGenderScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => LandingScreen(child: child),
        routes: [
          GoRoute(
            path: '/intro-calendar',
            builder: (context, state) => const IntroCalendarScreen(),
          ),
          GoRoute(
            path: '/calendar',
            builder: (context, state) => const CalendarScreen(),
          ),
          GoRoute(
            path: '/qr-scan',
            builder: (context, state) => const QrScanScreen(),
          ),
          GoRoute(
            path: '/intro-chat',
            builder: (context, state) => const IntroChatScreen(),
          ),
          GoRoute(
            path: '/chat',
            name: 'chat',
            builder: (context, state) => const ChatScreen(),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/intro-audio',
            builder: (context, state) => const IntroAudioScreen(),
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
          GoRoute(
            path: '/intro-profile',
            builder: (context, state) => IntroPersonalInfoScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => PersonalInfoScreen(),
          ),
        ],
      ),
    ],
  );
});
