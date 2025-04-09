import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  MyAudioHandler() {
    _player.playbackEventStream.listen((event) {
      playbackState.add(_transformEvent(event));
    });

    // รองรับการเล่นเพลงซ้ำเพลงเดิม (RepeatMode.one)
    _player.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        // ตรวจสอบว่ากำลังอยู่ในโหมด repeat one หรือไม่
        // ถ้าใช่ ให้เล่นซ้ำเพลงเดิม
        // ถ้าไม่ ให้ไปเพลงถัดไป
        // คุณจะต้องใช้ Provider หรือ Callback เพื่อเข้าถึงค่า RepeatMode จาก AudioPlayerState
      }
    });
  }

  // เพิ่มเมธอดสำหรับดึงความยาวของเพลง
  Duration getDuration() {
    return _player.duration ?? Duration.zero;
  }

  // ฟังก์ชันสำหรับติดตามการเปลี่ยนแปลงของความยาวเพลง
  Stream<Duration> get durationStream =>
      _player.durationStream.map((duration) => duration ?? Duration.zero);

  Future<void> playMedia(String path, MediaItem item) async {
    if (_player.audioSource != null && item.id == mediaItem.value?.id) return;

    mediaItem.add(item);
    await _player.setAudioSource(AudioSource.asset(path));
    await _player.play();
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        _player.playing ? MediaControl.pause : MediaControl.play,
        MediaControl.skipToNext,
      ],
      playing: _player.playing,
      updatePosition: _player.position,
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      systemActions: const {
        MediaAction.play,
        MediaAction.pause,
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
    );
  }

  @override
  Future<void> play() => _player.play();
  @override
  Future<void> pause() => _player.pause();
  @override
  Future<void> stop() => _player.stop();
  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();
  @override
  Future<void> skipToNext() => _player.seekToNext();
}
