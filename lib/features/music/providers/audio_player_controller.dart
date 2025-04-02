import 'package:audio_service/audio_service.dart';
import 'package:cunex_wellness/features/music/providers/audio_handler.dart';
import 'package:get/get.dart';

class AudioPlayerController extends GetxController {
  final isPlaying = false.obs;
  final totalDuration = Duration.zero.obs;
  late AudioHandler audioHandler;

  @override
  void onInit() {
    super.onInit();
    audioHandler = Get.find<AudioHandler>();

    // รับฟังการเปลี่ยนแปลงสถานะการเล่น
    audioHandler.playbackState.listen((playbackState) {
      isPlaying.value = playbackState.playing;
    });
  }

  Future<void> loadAndPlay(String path, String title, String category) async {
    final handler = audioHandler as MyAudioHandler;
    final mediaItem = MediaItem(id: path, title: title, album: category);

    await handler.playMedia(path, mediaItem);

    // ตั้งค่าระยะเวลารวม (จำลอง)
    totalDuration.value = const Duration(minutes: 5);
  }

  void togglePlayPause() {
    isPlaying.value ? audioHandler.pause() : audioHandler.play();
  }
}
