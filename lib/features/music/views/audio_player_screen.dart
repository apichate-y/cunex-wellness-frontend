import 'package:cunex_wellness/config/color.dart';
import 'package:cunex_wellness/core/services/background_service.dart';
import 'package:cunex_wellness/core/widgets/custom_appbar.dart';
import 'package:cunex_wellness/features/music/models/audio_player_model.dart';
import 'package:cunex_wellness/features/music/providers/audio_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AudioPlayerScreen extends ConsumerStatefulWidget {
  final String title;
  final String category;
  final String path;

  const AudioPlayerScreen({
    super.key,
    required this.title,
    required this.category,
    required this.path,
  });

  @override
  ConsumerState<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends ConsumerState<AudioPlayerScreen> {
  late AudioHandler handler;

  @override
  void initState() {
    super.initState();
    handler = ref.read(audioHandlerProvider);
  }

  @override
  Widget build(BuildContext context) {
    final audioState = ref.watch(audioPlayerProvider);
    final backgroundImage = ref.watch(backgroundImageProvider);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false, // ไม่ใช้ SafeArea ด้านล่างเพื่อให้ UI เต็มจอ
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomAppbar(level: 1, progress: 0.5),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
                              onPressed: () => context.pop(),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  widget.category,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            // ปุ่มที่มองไม่เห็นเพื่อจัดสมดุลให้หัวข้ออยู่ตรงกลาง
                            const SizedBox(width: 48),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: screenSize.width *
                                0.7, // ใช้ความกว้างหน้าจอมากำหนดความสูง
                            width: screenSize.width *
                                0.7, // ให้เป็นสี่เหลี่ยมจัตุรัส
                            color: Colors.white,
                            child: const Icon(Icons.music_note,
                                size: 80, color: AppTheme.rosePink),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.category,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        StreamBuilder<Duration>(
                          stream: AudioService.position,
                          builder: (context, snapshot) {
                            Duration position = snapshot.data ?? Duration.zero;
                            Duration total = audioState.totalDuration;

                            // ป้องกันการแสดง slider ที่ไม่ถูกต้อง
                            double sliderPosition =
                                position.inMilliseconds.toDouble();
                            double sliderMax = total.inMilliseconds.toDouble();

                            // ตรวจสอบว่า position ต้องไม่เกิน total
                            double validPosition = sliderPosition <= sliderMax
                                ? sliderPosition
                                : 0;

                            return Column(
                              children: [
                                SliderTheme(
                                  data: SliderThemeData(
                                    trackHeight: 4,
                                    thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 8),
                                  ),
                                  child: Slider(
                                      value: validPosition,
                                      max: sliderMax > 0 ? sliderMax : 1,
                                      min: 0,
                                      onChanged: (value) => handler.seek(
                                          Duration(
                                              milliseconds: value.toInt())),
                                      activeColor: AppTheme.rosePink,
                                      inactiveColor:
                                          AppTheme.white.withOpacity(0.5)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(_formatDuration(position),
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      Text(
                                          total.inMilliseconds > 0
                                              ? _formatDuration(total)
                                              : '00:00',
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(audioPlayerProvider.notifier)
                                    .toggleShuffle();
                              },
                              icon: Icon(
                                Icons.shuffle,
                                color: audioState.shuffleEnabled
                                    ? AppTheme.rosePink
                                    : AppTheme.white,
                                size: 24,
                              ),
                              iconSize: 28,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(audioPlayerProvider.notifier)
                                    .skipToPrevious();
                              },
                              icon: const Icon(
                                Icons.skip_previous,
                                color: AppTheme.white,
                              ),
                              iconSize: 35,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                backgroundColor: AppTheme.white,
                                radius: 30,
                                child: IconButton(
                                  icon: Icon(
                                    audioState.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: audioState.isPlaying
                                        ? AppTheme.rosePink
                                        : Colors.grey,
                                    size: 30,
                                  ),
                                  onPressed: () => ref
                                      .read(audioPlayerProvider.notifier)
                                      .togglePlayPause(),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(audioPlayerProvider.notifier)
                                    .skipToNext();
                              },
                              icon: const Icon(
                                Icons.skip_next,
                                color: AppTheme.white,
                              ),
                              iconSize: 35,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(audioPlayerProvider.notifier)
                                    .toggleRepeatMode();
                              },
                              icon: Icon(
                                audioState.repeatMode == RepeatMode.one
                                    ? Icons.repeat_one
                                    : Icons.repeat,
                                color: audioState.repeatMode != RepeatMode.off
                                    ? AppTheme.rosePink
                                    : AppTheme.white,
                                size: 24,
                              ),
                              iconSize: 28,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        // เพิ่ม padding ด้านล่างให้พอดีกับ bottom navigation bar
                        SizedBox(
                            height: MediaQuery.of(context).padding.bottom + 80),
                      ],
                    ),
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
