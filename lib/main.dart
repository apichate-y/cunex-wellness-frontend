import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:cunex_wellness/core/controllers/background_controller.dart';
import 'package:cunex_wellness/core/controllers/image_cache_controller.dart';
import 'package:cunex_wellness/features/avartar_customizer/providers/bot_gender_controller.dart';
import 'package:cunex_wellness/features/calendar/providers/calendar_controller.dart';
import 'package:cunex_wellness/features/calendar/providers/qr_code_provider.dart';
import 'package:cunex_wellness/features/chat_bot/providers/chat_controller.dart';
import 'package:cunex_wellness/features/home/providers/home_controller.dart';
import 'package:cunex_wellness/features/landing/providers/navigation_controller.dart';
import 'package:cunex_wellness/features/music/providers/audio_handler.dart';
import 'package:cunex_wellness/features/music/providers/audio_player_controller.dart';
import 'package:cunex_wellness/features/music/providers/audio_playlist_controller.dart';
import 'package:cunex_wellness/features/splash_screen/providers/splash_controller.dart';
import 'package:cunex_wellness/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // เริ่มต้น Hive และโหลดรูปภาพ
  await Hive.initFlutter();

  // สร้าง controller แต่ยังไม่ได้เริ่มต้นการโหลดรูปภาพ
  final imageCacheController = Get.put(ImageCacheController());
  // รอให้การโหลดรูปภาพเสร็จสิ้น
  await imageCacheController.initHive(); // ต้องมี await ตรงนี้

  // ลงทะเบียน Controller
  Get.put(BackgroundController());
  Get.put(SplashController());
  Get.put(BotGenderController());
  Get.put(NavigationController());
  Get.put(HomeController());
  Get.put(CalendarController());
  Get.put(QrScanController());
  Get.put(ChatController());

  Intl.defaultLocale = "th";
  await initializeDateFormatting('th_TH', null);

  final session = await AudioSession.instance;
  await session.configure(AudioSessionConfiguration.music());

  final handler = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'channel.audio',
    ),
  );

  // final botGender = await PreferencesManager.loadBotGender();
  // ChatBotService.setGender(botGender);

  setUrlStrategy(const HashUrlStrategy());

  // สร้าง AudioHandler Controller กับ GetX
  Get.put<AudioHandler>(handler);
  Get.put(AudioPlayerController());
  Get.put(AudioPlaylistController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CUNEX: Wellness',
      builder:
          (context, child) => ResponsiveWrapper.builder(
            child,
            maxWidth: 1200,
            minWidth: 360,
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.resize(360, name: MOBILE),
              ResponsiveBreakpoint.autoScale(600, name: TABLET),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ],
            background: Container(color: const Color(0xFFF5F5F5)),
          ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('th', 'TH'),
      supportedLocales: const [Locale('th', 'TH')],
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'CHULALONGKORN',
        textTheme: Theme.of(
          context,
        ).textTheme.apply(fontFamily: 'CHULALONGKORN'),
        primaryTextTheme: Theme.of(
          context,
        ).textTheme.apply(fontFamily: 'CHULALONGKORN'),
      ),
    );
  }
}
