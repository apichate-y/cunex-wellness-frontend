import 'package:audio_service/audio_service.dart';
import 'package:cunex_wellness/config/color.dart';
import 'package:cunex_wellness/core/controllers/background_controller.dart';
import 'package:cunex_wellness/core/widgets/custom_appbar.dart';
import 'package:cunex_wellness/features/music/providers/audio_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayerController audioController;
  late AudioHandler handler;
  late BackgroundController backgroundController;
  late String title;
  late String category;
  late String path;
  bool _hasLoaded = false;

  @override
  void initState() {
    super.initState();
    audioController = Get.find<AudioPlayerController>();
    handler = Get.find<AudioHandler>();
    backgroundController = Get.find<BackgroundController>();

    // รับพารามิเตอร์จาก arguments
    final args = Get.arguments as Map<String, String?>;
    title = args['title'] ?? '';
    category = args['category'] ?? '';
    path = args['path'] ?? '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasLoaded) {
      _hasLoaded = true;
      audioController.loadAndPlay(path, title, category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundController.backgroundImage.value),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: CustomAppbar(level: 1, progress: 0.5),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white,
                              size: 32,
                            ),
                            onPressed: () => Get.back(),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Center(
                              child: Text(
                                category,
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Container(
                        height: 300,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        color: Colors.white,
                        child: const Icon(
                          Icons.music_note,
                          size: 100,
                          color: AppTheme.rosePink,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      StreamBuilder<Duration>(
                        stream: AudioService.position,
                        builder: (context, snapshot) {
                          final position = snapshot.data ?? Duration.zero;
                          final total = audioController.totalDuration.value;

                          return Column(
                            children: [
                              Slider(
                                value: position.inSeconds.toDouble(),
                                max: total.inSeconds.toDouble().clamp(
                                  1,
                                  double.infinity,
                                ),
                                onChanged:
                                    (value) => handler.seek(
                                      Duration(seconds: value.toInt()),
                                    ),
                                activeColor: AppTheme.rosePink,
                                inactiveColor: AppTheme.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _formatDuration(position),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      _formatDuration(total),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(Icons.shuffle, color: AppTheme.white),
                          const Icon(
                            Icons.skip_previous,
                            color: AppTheme.white,
                          ),
                          Obx(
                            () => CircleAvatar(
                              backgroundColor: AppTheme.white,
                              radius: 30,
                              child: IconButton(
                                icon: Icon(
                                  audioController.isPlaying.value
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color:
                                      audioController.isPlaying.value
                                          ? AppTheme.rosePink
                                          : Colors.grey,
                                  size: 30,
                                ),
                                onPressed:
                                    () => audioController.togglePlayPause(),
                              ),
                            ),
                          ),
                          const Icon(Icons.skip_next, color: AppTheme.white),
                          const Icon(Icons.repeat, color: AppTheme.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
