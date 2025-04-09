import 'package:audio_service/audio_service.dart';

enum RepeatMode { off, one, all }

class AudioPlayerModel {
  final bool isPlaying;
  final Duration totalDuration;
  final bool shuffleEnabled;
  final RepeatMode repeatMode;
  final int currentIndex;
  final List<MediaItem> playlist;

  AudioPlayerModel({
    required this.isPlaying, 
    required this.totalDuration,
    required this.shuffleEnabled,
    required this.repeatMode,
    required this.currentIndex,
    required this.playlist,
  });

  factory AudioPlayerModel.initial() => AudioPlayerModel(
    isPlaying: false, 
    totalDuration: Duration.zero,
    shuffleEnabled: false,
    repeatMode: RepeatMode.off,
    currentIndex: 0,
    playlist: [],
  );

  AudioPlayerModel copyWith({
    bool? isPlaying, 
    Duration? totalDuration,
    bool? shuffleEnabled,
    RepeatMode? repeatMode,
    int? currentIndex,
    List<MediaItem>? playlist,
  }) {
    return AudioPlayerModel(
      isPlaying: isPlaying ?? this.isPlaying,
      totalDuration: totalDuration ?? this.totalDuration,
      shuffleEnabled: shuffleEnabled ?? this.shuffleEnabled,
      repeatMode: repeatMode ?? this.repeatMode,
      currentIndex: currentIndex ?? this.currentIndex,
      playlist: playlist ?? this.playlist,
    );
  }
}