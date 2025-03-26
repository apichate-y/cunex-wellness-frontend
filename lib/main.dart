import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = "th";
  await initializeDateFormatting('th_TH', null);

    final session = await AudioSession.instance;
  await session.configure(AudioSessionConfiguration.music());

  final handler = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(androidNotificationChannelId: 'channel.audio'),
  );

  final botGender = await PreferencesManager.loadBotGender();
  ChatBotService.setGender(botGender);

  runApp(
    ProviderScope(
      overrides: [
      audioHandlerProvider.overrideWithValue(handler),
    ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CUNEX: Wellness',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('th', 'TH'),
      supportedLocales: const [Locale('th', 'TH')],
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
