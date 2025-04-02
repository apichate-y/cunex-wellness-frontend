import 'package:cunex_wellness/features/avartar_customizer/providers/bot_gender_controller.dart';
import 'package:cunex_wellness/features/avartar_customizer/views/bot_gender_screen.dart';
import 'package:cunex_wellness/features/calendar/providers/calendar_controller.dart';
import 'package:cunex_wellness/features/calendar/providers/qr_code_provider.dart';
import 'package:cunex_wellness/features/calendar/views/calendar_screen.dart';
import 'package:cunex_wellness/features/calendar/views/qr_scan_screen.dart';
import 'package:cunex_wellness/features/chat_bot/providers/chat_controller.dart';
import 'package:cunex_wellness/features/chat_bot/views/chat_screen.dart';
import 'package:cunex_wellness/features/home/providers/home_controller.dart';
import 'package:cunex_wellness/features/home/views/home_screen.dart';
import 'package:cunex_wellness/features/landing/views/landing_screen.dart';
import 'package:cunex_wellness/features/music/providers/audio_player_controller.dart';
import 'package:cunex_wellness/features/music/providers/audio_playlist_controller.dart';
import 'package:cunex_wellness/features/music/views/audio_player_screen.dart';
import 'package:cunex_wellness/features/music/views/audio_playlist_screen.dart';
import 'package:cunex_wellness/features/profile/views/personal_info_screen.dart';
import 'package:cunex_wellness/features/splash_screen/views/splash_screen.dart';
import 'package:cunex_wellness/routes/route_guard.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: Routes.BOT_GENDER,
      page: () => BotGenderScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => BotGenderController());
      }),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: Routes.CALENDAR,
      page: () => LandingScreen(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<CalendarController>()) {
          Get.put(CalendarController());
        }
      }),
      middlewares: [
        RouteGuard(0), // กำหนด index = 0 (CALENDAR)
      ],
      // transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.CHAT,
      page: () => LandingScreen(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<ChatController>()) {
          Get.put(ChatController());
        }
      }),
      middlewares: [
        RouteGuard(1), // กำหนด index = 1 (CHAT)
      ],
      // transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.HOME,
      page: () => LandingScreen(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<HomeController>()) {
          Get.put(HomeController());
        }
      }),
      middlewares: [
        RouteGuard(2), // กำหนด index = 2 (HOME)
      ],
      // transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.PLAYLIST,
      page: () => LandingScreen(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<AudioPlaylistController>()) {
          Get.put(AudioPlaylistController());
        }
      }),
      middlewares: [
        RouteGuard(3), // กำหนด index = 3 (PLAYLIST)
      ],
      // transition: Transition.rightToLeft,
    ),

    GetPage(
      name: Routes.PROFILE,
      page: () => LandingScreen(),
      middlewares: [
        RouteGuard(4), // กำหนด index = 4 (PROFILE)
      ],
      // transition: Transition.rightToLeft,
    ),

    GetPage(
      name: Routes.QR_SCAN,
      page: () => LandingScreen(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<QrScanController>()) {
          Get.put(QrScanController());
        }
      }),
      // transition: Transition.rightToLeft,
    ),

    GetPage(
      name: Routes.PLAYER,
      page: () => AudioPlayerScreen(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<AudioPlayerController>()) {
          Get.put(AudioPlayerController());
        }
      }),
      // transition: Transition.rightToLeft,
    ),
  ];
}
