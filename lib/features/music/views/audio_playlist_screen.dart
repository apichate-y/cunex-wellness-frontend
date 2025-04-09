import 'package:cunex_wellness/core/services/background_service.dart';
import 'package:cunex_wellness/core/widgets/custom_appbar.dart';
import 'package:cunex_wellness/features/music/providers/audio_player_provider.dart';
import 'package:cunex_wellness/features/music/views/category_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final selectedCategoryProvider = StateProvider<String?>((ref) => null);
final searchQueryProvider = StateProvider<String>((ref) => '');

final audioFilesProvider = Provider<Map<String, List<Map<String, String>>>>(
  (ref) => {
    'Sleep': [
      {
        'title': 'Moonlit Waves',
        'path': 'lib/assets/sounds/sleep/Moonlit Waves.mp3',
      },
      {
        'title': 'Deep Sleep Waves',
        'path': 'lib/assets/sounds/sleep/Deep Sleep Waves.mp3',
      },
      {
        'title': 'Dream Cascade',
        'path': 'lib/assets/sounds/sleep/Dream Cascade.mp3',
      },
      {'title': 'Dreamwaves', 'path': 'lib/assets/sounds/sleep/Dreamwaves.mp3'},
      {
        'title': 'Starlit Dreams',
        'path': 'lib/assets/sounds/sleep/Starlit Dreams.mp3',
      },
    ],
    'Focus': [
      {
        'title': 'Flowing Mindstream',
        'path': 'lib/assets/sounds/focus/Flowing Mindstream.mp3',
      },
      {
        'title': 'Echoes of the Forest',
        'path': 'lib/assets/sounds/focus/Echoes of the Forest.mp3',
      },
      {'title': 'Flow State', 'path': 'lib/assets/sounds/focus/Flow State.mp3'},
      {
        'title': 'Forest Pulse',
        'path': 'lib/assets/sounds/focus/Forest Pulse.mp3',
      },
      {
        'title': 'Stay Steady',
        'path': 'lib/assets/sounds/focus/Stay Steady.mp3',
      },
    ],
    'Wellness': [
      {
        'title': 'Healing Earth',
        'path': 'lib/assets/sounds/wellness/Healing Earth.mp3',
      },
      {
        'title': 'Golden Glow',
        'path': 'lib/assets/sounds/wellness/Golden Glow.mp3',
      },
      {
        'title': 'Serenity Sparks',
        'path': 'lib/assets/sounds/wellness/Serenity Sparks.mp3',
      },
      {
        'title': 'Tranquil Springs',
        'path': 'lib/assets/sounds/wellness/Tranquil Springs.mp3',
      },
      {
        'title': 'Wellness Groove',
        'path': 'lib/assets/sounds/wellness/Wellness Groove.mp3',
      },
    ],
    'Chill': [
      {
        'title': 'Twilight Harmony',
        'path': 'lib/assets/sounds/chill/Twilight Harmony.mp3',
      },
      {
        'title': 'Breathe Easy',
        'path': 'lib/assets/sounds/chill/Breathe Easy.mp3',
      },
      {
        'title': 'Gentle Waves',
        'path': 'lib/assets/sounds/chill/Gentle Waves.mp3',
      },
      {'title': 'Slow Down', 'path': 'lib/assets/sounds/chill/Slow Down.mp3'},
      {
        'title': 'Sunset Drift',
        'path': 'lib/assets/sounds/chill/Sunset Drift.mp3',
      },
      {
        'title': 'Waves in My Soul',
        'path': 'lib/assets/sounds/chill/Waves in My Soul.mp3',
      },
    ],
  },
);

class AudioPlaylistScreen extends ConsumerWidget {
  const AudioPlaylistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final audioFiles = ref.watch(audioFilesProvider);
    final backgroundImage = ref.watch(backgroundImageProvider);

    // 🔍 Search filtering
    final List<Map<String, String>> searchResults = [];
    for (var entry in audioFiles.entries) {
      final category = entry.key;
      final tracks = entry.value;
      final filtered = tracks.where((track) {
        final lower = searchQuery.toLowerCase();
        return track['title']!.toLowerCase().contains(lower) ||
            category.toLowerCase().contains(lower);
      }).toList();
      searchResults.addAll(filtered);
    }

    final List<Map<String, String>> displayTracks = searchQuery.isNotEmpty
        ? searchResults
        : selectedCategory != null
            ? audioFiles[selectedCategory] ?? []
            : audioFiles.entries.map((e) => e.value.first).toList();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: CustomAppbar(
                level: 1,
                progress: 0.5,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'DJ Nexky',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      onChanged: (value) =>
                          ref.read(searchQueryProvider.notifier).state = value,
                      decoration: InputDecoration(
                        hintText: 'What do you want to listen to?',
                        contentPadding: EdgeInsets.zero,
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (var category in [
                            'Sleep',
                            'Focus',
                            'Wellness',
                            'Chill',
                          ])
                            CategoryFilterButton(
                              category: category,
                              label: category,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Recommended Stations',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 80),
                        itemCount: displayTracks.length,
                        itemBuilder: (context, index) {
                          final track = displayTracks[index];
                          final category = audioFiles.entries
                              .firstWhere((e) => e.value.contains(track))
                              .key;

                          return ListTile(
                            leading: const Icon(
                              Icons.music_note,
                              color: Colors.white,
                            ),
                            title: Text(
                              track['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              category,
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            onTap: () async {
                              final audioController = ref.read(
                                audioPlayerProvider.notifier,
                              );

                              context.push(
                                '/player',
                                extra: {
                                  'title': track['title'],
                                  'category': category,
                                  'path': track['path'],
                                },
                              );

                              await audioController.loadAndPlay(
                                track['path']!,
                                track['title']!,
                                category,
                              );
                            },
                          );
                        },
                      ),
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
}
