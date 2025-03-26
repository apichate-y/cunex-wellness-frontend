// ✅ audio_player_screen.dart
import 'package:audio_service/audio_service.dart';
import 'package:cunex_wellness/core/widgets/custom_appbar.dart';
import 'package:cunex_wellness/features/music/providers/audio_player_provider.dart';
import 'package:flutter/material.dart';
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
  late final AudioHandler handler;
  bool _hasLoaded = false;

  @override
  void initState() {
    super.initState();
    handler = ref.read(audioHandlerProvider);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasLoaded) {
      _hasLoaded = true;
      ref.read(audioPlayerProvider.notifier).loadAndPlay(
            widget.path,
            widget.title,
            widget.category,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final audioState = ref.watch(audioPlayerProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/bg/bg_night.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: CustomAppbar(level: 1, progress: 0.5,),
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
                          onPressed: () => context.pop(),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Center(
                            child: Text(
                              widget.category,
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
                        color: Colors.pink,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      widget.title,
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
                        final total = audioState.totalDuration;

                        return Column(
                          children: [
                            Slider(
                              value: position.inSeconds.toDouble(),
                              max: total.inSeconds.toDouble().clamp(1, double.infinity),
                              onChanged: (value) => handler.seek(Duration(seconds: value.toInt())),
                              activeColor: Colors.pink,
                              inactiveColor: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_formatDuration(position), style: const TextStyle(color: Colors.white)),
                                  Text(_formatDuration(total), style: const TextStyle(color: Colors.white)),
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
                        const Icon(Icons.shuffle, color: Colors.white),
                        const Icon(Icons.skip_previous, color: Colors.white),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          child: IconButton(
                            icon: Icon(
                              audioState.isPlaying ? Icons.pause : Icons.play_arrow,
                              color: audioState.isPlaying ? Colors.pink : Colors.grey,
                              size: 30,
                            ),
                            onPressed: () => ref.read(audioPlayerProvider.notifier).togglePlayPause(),
                          ),
                        ),
                        const Icon(Icons.skip_next, color: Colors.white),
                        const Icon(Icons.repeat, color: Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
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
