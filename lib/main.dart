import 'package:cunex_wellness/core/services/chatbot_service.dart';
import 'package:cunex_wellness/core/services/preferences_manager.dart';
import 'package:cunex_wellness/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final botGender = await PreferencesManager.loadBotGender();
  ChatBotService.setGender(botGender);

  runApp(const ProviderScope(child: MyApp()));
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
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
