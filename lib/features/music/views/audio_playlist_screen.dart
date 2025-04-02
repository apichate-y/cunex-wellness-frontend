import 'package:cunex_wellness/core/controllers/background_controller.dart';
import 'package:cunex_wellness/core/widgets/custom_appbar.dart';
import 'package:cunex_wellness/features/music/providers/audio_player_controller.dart';
import 'package:cunex_wellness/features/music/providers/audio_playlist_controller.dart';
import 'package:cunex_wellness/features/music/views/category_filter.dart';
import 'package:cunex_wellness/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioPlaylistScreen extends StatelessWidget {
  const AudioPlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AudioPlaylistController>();
    final backgroundController = Get.find<BackgroundController>();

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
                        onChanged:
                            (value) => controller.searchQuery.value = value,
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
                              GetX<AudioPlaylistController>(
                                builder:
                                    (_) => CategoryFilterButton(
                                      category: category,
                                      label: category,
                                      isSelected:
                                          controller.selectedCategory.value ==
                                          category,
                                      onTap:
                                          () => controller.toggleCategory(
                                            category,
                                          ),
                                    ),
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
                      Obx(() {
                        final displayTracks = controller.getDisplayTracks();

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: displayTracks.length,
                          itemBuilder: (context, index) {
                            final track = displayTracks[index];
                            final category = controller.getCategoryForTrack(
                              track,
                            );

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
                                final audioController =
                                    Get.find<AudioPlayerController>();

                                Get.toNamed(
                                  Routes.PLAYER,
                                  arguments: {
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
                        );
                      }),
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
}
