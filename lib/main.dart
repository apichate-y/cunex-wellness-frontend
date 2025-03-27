import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:cunex_wellness/core/providers/navigator_key_provider.dart';
import 'package:cunex_wellness/core/services/chatbot_service.dart';
import 'package:cunex_wellness/core/services/preferences_manager.dart';
import 'package:cunex_wellness/features/music/providers/audio_handler.dart';
import 'package:cunex_wellness/features/music/providers/audio_player_provider.dart';
import 'package:cunex_wellness/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  final botGender = await PreferencesManager.loadBotGender();
  ChatBotService.setGender(botGender);

  runApp(
    ProviderScope(
      overrides: [audioHandlerProvider.overrideWithValue(handler)],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'CUNEX: Wellness',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      builder:
          (context, child) => ResponsiveBreakpoints.builder(
            child: ClampingScrollWrapper.builder(context, child!),
            breakpoints: [
              const Breakpoint(start: 0, end: 479, name: MOBILE),
              const Breakpoint(start: 480, end: 799, name: TABLET),
              const Breakpoint(start: 800, end: 999, name: TABLET),
              const Breakpoint(
                start: 1000,
                end: double.infinity,
                name: DESKTOP,
              ),
            ],
          ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('th', 'TH'),
      supportedLocales: const [Locale('th', 'TH')],
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
    );
  }
}
