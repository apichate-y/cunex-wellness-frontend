import 'package:get/get.dart';

class AudioPlaylistController extends GetxController {
  final selectedCategory = Rx<String?>(null);
  final searchQuery = ''.obs;
  
  final Map<String, List<Map<String, String>>> audioFiles = {
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
  };
  
  void toggleCategory(String category) {
    if (selectedCategory.value == category) {
      selectedCategory.value = null;
    } else {
      selectedCategory.value = category;
    }
  }
  
  List<Map<String, String>> getDisplayTracks() {
    if (searchQuery.isNotEmpty) {
      return getSearchResults();
    } else if (selectedCategory.value != null) {
      return audioFiles[selectedCategory.value] ?? [];
    } else {
      return audioFiles.entries.map((e) => e.value.first).toList();
    }
  }
  
  List<Map<String, String>> getSearchResults() {
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
    return searchResults;
  }
  
  String getCategoryForTrack(Map<String, String> track) {
    for (var entry in audioFiles.entries) {
      if (entry.value.contains(track)) {
        return entry.key;
      }
    }
    return '';
  }
}