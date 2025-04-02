import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ImageCacheController extends GetxController {
  late Box<Uint8List> imageCache;
  final isInitialized = false.obs;

  // รายการรูปภาพที่ต้องการโหลด
  final List<String> imagePaths = [
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
    'lib/assets/images/mascot/iconnie.png',
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
    // เพิ่มรูปภาพอื่นๆ ที่ใช้ในแอป
  ];

  Future<void> initHive() async {
    try {
      await Hive.initFlutter();
      imageCache = await Hive.openBox<Uint8List>('image_cache');
      await preloadImages();
    } catch (e) {
      log('Error initializing Hive: $e');
      isInitialized.value = true; // ให้แอปทำงานต่อไปแม้มีข้อผิดพลาด
    }
  }

  Future<void> preloadImages() async {
    try {
      for (String path in imagePaths) {
        String key = path.split('/').last;

        // ตรวจสอบว่ามีรูปภาพในแคชหรือไม่
        if (!imageCache.containsKey(key)) {
          ByteData data = await rootBundle.load(path);
          Uint8List bytes = data.buffer.asUint8List();
          await imageCache.put(key, bytes);
        }
      }
      isInitialized.value = true;
    } catch (e) {
      log('Error preloading images: $e');
      isInitialized.value = true;
    }
  }

  Uint8List? getImage(String path) {
    String key = path.split('/').last;
    return imageCache.get(key);
  }

  ImageProvider getImageProvider(String path) {
    Uint8List? bytes = getImage(path);
    if (bytes != null) {
      return MemoryImage(bytes);
    }
    // Fallback ใช้ AssetImage
    return AssetImage(path);
  }
}
