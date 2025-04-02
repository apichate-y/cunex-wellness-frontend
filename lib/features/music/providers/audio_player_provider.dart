// import 'package:audio_service/audio_service.dart';
// import 'package:cunex_wellness/features/music/providers/audio_handler.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final audioHandlerProvider = Provider<AudioHandler>((ref) {
//   throw UnimplementedError(); // Init จาก main
// });

// final audioPlayerProvider =
//     AutoDisposeNotifierProvider<AudioPlayerNotifier, AudioPlayerState>(
//       AudioPlayerNotifier.new,
//     );

// class AudioPlayerState {
//   final bool isPlaying;
//   final Duration totalDuration;

//   AudioPlayerState({required this.isPlaying, required this.totalDuration});

//   factory AudioPlayerState.initial() =>
//       AudioPlayerState(isPlaying: false, totalDuration: Duration.zero);

//   AudioPlayerState copyWith({bool? isPlaying, Duration? totalDuration}) {
//     return AudioPlayerState(
//       isPlaying: isPlaying ?? this.isPlaying,
//       totalDuration: totalDuration ?? this.totalDuration,
//     );
//   }
// }

// class AudioPlayerNotifier extends AutoDisposeNotifier<AudioPlayerState> {
//   @override
//   AudioPlayerState build() {
//     final handler = ref.watch(audioHandlerProvider);
//     handler.playbackState.listen((playbackState) {
//       state = state.copyWith(isPlaying: playbackState.playing);
//     });
//     return AudioPlayerState.initial();
//   }

//   Future<void> loadAndPlay(String path, String title, String category) async {
//     final handler = ref.read(audioHandlerProvider) as MyAudioHandler;
//     final mediaItem = MediaItem(id: path, title: title, album: category);

//     await handler.playMedia(path, mediaItem);
//     state = state.copyWith(
//       totalDuration: Duration(minutes: 5),
//     ); // หรือ set จาก source จริง
//   }

//   void togglePlayPause() {
//     final handler = ref.read(audioHandlerProvider);
//     state.isPlaying ? handler.pause() : handler.play();
//   }
// }
