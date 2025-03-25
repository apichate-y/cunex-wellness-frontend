import 'package:cunex_wellness/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:go_router/go_router.dart';

class AudioPlayerScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audioPlayerProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/bg/bg_night.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomAppbar(),
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white,
                              size: 32,
                            ),
                            onPressed: () => context.pop(),
                          ),
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
                        color: Colors.pink,
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
                      stream: player.currentPosition,
                      builder: (context, snapshot) {
                        final position = snapshot.data ?? Duration.zero;
                        final total =
                            player.current.hasValue
                                ? player.current.value!.audio.duration
                                : Duration.zero;

                        return Column(
                          children: [
                            Slider(
                              value: position.inSeconds.toDouble(),
                              max: total.inSeconds.toDouble(),
                              onChanged:
                                  (value) => player.seek(
                                    Duration(seconds: value.toInt()),
                                  ),
                              activeColor: Colors.pink,
                              inactiveColor: Colors.white,
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
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    _formatDuration(total),
                                    style: const TextStyle(color: Colors.white),
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
                        const Icon(Icons.shuffle, color: Colors.white),
                        IconButton(
                          icon: const Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                          ),
                          onPressed: () => player.previous(),
                        ),
                        StreamBuilder<bool>(
                          stream: player.isPlaying,
                          builder: (context, snapshot) {
                            final isPlaying = snapshot.data ?? false;
                            return CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              child: IconButton(
                                icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: isPlaying ? Colors.pink : Colors.grey,
                                  size: 30,
                                ),
                                onPressed: () => player.playOrPause(),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.skip_next,
                            color: Colors.white,
                          ),
                          onPressed: () => player.next(),
                        ),
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

final audioPlayerProvider = Provider<AssetsAudioPlayer>((ref) {
  final player = AssetsAudioPlayer.withId('main');
  return player;
});
