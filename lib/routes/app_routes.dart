import 'package:cunex_wellness/features/avartar_customizer/views/bot_gender_screen.dart';
import 'package:cunex_wellness/features/home/views/home.dart';
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
          (BuildContext context, GoRouterState state) => const BotGenderScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder:
          (BuildContext context, GoRouterState state) => const HomeScreen(),
    ),
  ],
);
