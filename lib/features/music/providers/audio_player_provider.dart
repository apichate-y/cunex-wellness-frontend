import 'package:audio_service/audio_service.dart';
import 'package:cunex_wellness/features/music/models/audio_player_model.dart';
import 'package:cunex_wellness/features/music/providers/audio_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioHandlerProvider = Provider<AudioHandler>((ref) {
  throw UnimplementedError(); // Init จาก main
});

final audioPlayerProvider =
    AutoDisposeNotifierProvider<AudioPlayerNotifier, AudioPlayerModel>(
      AudioPlayerNotifier.new,
    );

class AudioPlayerNotifier extends AutoDisposeNotifier<AudioPlayerModel> {
  @override
  AudioPlayerModel build() {
    final handler = ref.watch(audioHandlerProvider);
    
    // ฟังการเปลี่ยนแปลงสถานะการเล่น
    handler.playbackState.listen((playbackState) {
      state = state.copyWith(isPlaying: playbackState.playing);
    });
    
    // ฟังการเปลี่ยนแปลงความยาวของเพลง
    if (handler is MyAudioHandler) {
      handler.durationStream.listen((duration) {
        if (duration != Duration.zero && duration != state.totalDuration) {
          state = state.copyWith(totalDuration: duration);
        }
      });
    }
    
    return AudioPlayerModel.initial();
  }

  Future<void> loadAndPlay(String path, String title, String category) async {
    final handler = ref.read(audioHandlerProvider) as MyAudioHandler;
    final mediaItem = MediaItem(id: path, title: title, album: category);

    // สร้าง playlist ชั่วคราวหากยังไม่มี
    final newPlaylist = state.playlist.isEmpty 
        ? [mediaItem] 
        : List<MediaItem>.from(state.playlist);
    
    // ตรวจสอบว่า item นี้มีอยู่ใน playlist หรือไม่
    int index = newPlaylist.indexWhere((item) => item.id == mediaItem.id);
    if (index == -1) {
      // ถ้าไม่มีใน playlist ให้เพิ่มเข้าไป
      newPlaylist.add(mediaItem);
      index = newPlaylist.length - 1;
    }

    await handler.playMedia(path, mediaItem);
    
    // รอสักครู่เพื่อให้ player โหลดข้อมูลเสียงเสร็จก่อนดึงความยาว
    await Future.delayed(const Duration(milliseconds: 200));
    
    // กำหนดค่า totalDuration จากไฟล์เสียงจริง
    final duration = handler.getDuration();
    
    state = state.copyWith(
      totalDuration: duration,
      currentIndex: index,
      playlist: newPlaylist,
    );
  }

  void togglePlayPause() {
    final handler = ref.read(audioHandlerProvider);
    state.isPlaying ? handler.pause() : handler.play();
  }

  // เพิ่มฟังก์ชันสำหรับ shuffle
  void toggleShuffle() {
    state = state.copyWith(shuffleEnabled: !state.shuffleEnabled);
    // ในการใช้งานจริง คุณอาจต้องสลับลำดับใน playlist ด้วย
  }

  // เพิ่มฟังก์ชันสำหรับ previous track
  Future<void> skipToPrevious() async {
    if (state.playlist.isEmpty || state.currentIndex <= 0) return;
    
    final handler = ref.read(audioHandlerProvider) as MyAudioHandler;
    final prevIndex = state.currentIndex - 1;
    final prevItem = state.playlist[prevIndex];
    
    await handler.playMedia(prevItem.id, prevItem);
    state = state.copyWith(currentIndex: prevIndex);
  }

  // เพิ่มฟังก์ชันสำหรับ next track
  Future<void> skipToNext() async {
    if (state.playlist.isEmpty || state.currentIndex >= state.playlist.length - 1) {
      if (state.repeatMode == RepeatMode.all) {
        // วนกลับไปเล่นเพลงแรก
        final firstItem = state.playlist[0];
        final handler = ref.read(audioHandlerProvider) as MyAudioHandler;
        await handler.playMedia(firstItem.id, firstItem);
        state = state.copyWith(currentIndex: 0);
      }
      return;
    }
    
    final handler = ref.read(audioHandlerProvider) as MyAudioHandler;
    final nextIndex = state.currentIndex + 1;
    final nextItem = state.playlist[nextIndex];
    
    await handler.playMedia(nextItem.id, nextItem);
    state = state.copyWith(currentIndex: nextIndex);
  }

  // เพิ่มฟังก์ชันสำหรับ repeat mode
  void toggleRepeatMode() {
    final nextMode = switch (state.repeatMode) {
      RepeatMode.off => RepeatMode.one,
      RepeatMode.one => RepeatMode.all,
      RepeatMode.all => RepeatMode.off,
    };
    
    state = state.copyWith(repeatMode: nextMode);
  }
}