import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'navigator_key_provider.dart';

final assetsPrecacheProvider = FutureProvider<void>((ref) async {
  final context = ref.read(navigatorKeyProvider).currentContext;

  if (context == null) return;

  final assetsToCache = [
    'lib/assets/images/bg/bg_early_morning.png',
    'lib/assets/images/bg/bg_evening.png',
    'lib/assets/images/bg/bg_night.png',
    'lib/assets/images/bg/bg_noon.png',
    'lib/assets/images/element/a.png',
    'lib/assets/images/element/b.png',
    'lib/assets/images/element/j.png',
    'lib/assets/images/icons/5 main buttons/calendar.png',
    'lib/assets/images/icons/5 main buttons/calendar2.png',
    'lib/assets/images/icons/5 main buttons/chat.png',
    'lib/assets/images/icons/5 main buttons/chat2.png',
    'lib/assets/images/icons/5 main buttons/home.png',
    'lib/assets/images/icons/5 main buttons/home2.png',
    'lib/assets/images/icons/5 main buttons/music.png',
    'lib/assets/images/icons/5 main buttons/music2.png',
    'lib/assets/images/icons/5 main buttons/profile.png',
    'lib/assets/images/icons/5 main buttons/profile2.png',
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-07.png',
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-08.png',
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-09.png',
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-10.png',
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-11.png',
    'lib/assets/images/icons/เมฆ emotion/Untitled-24-12.png',
    'lib/assets/images/mascot/nexky character-06.png',
    'lib/assets/images/mascot/nexky character-07.png',
    'lib/assets/images/mascot/nexky character-09.png',
    'lib/assets/images/word/1.png',
    'lib/assets/images/word/10.png',
    'lib/assets/images/word/11.png',
    'lib/assets/images/word/2.png',
    'lib/assets/images/word/3.png',
    'lib/assets/images/word/4.png',
    'lib/assets/images/word/8.png',
    // เพิ่มรูปอื่นๆ ได้ที่นี่
  ];

  for (final path in assetsToCache) {
    await precacheImage(AssetImage(path), context);
  }
});