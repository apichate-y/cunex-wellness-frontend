import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  MyAudioHandler() {
    _player.playbackEventStream.listen((event) {
      playbackState.add(_transformEvent(event));
    });
  }

  Future<void> playMedia(String path, MediaItem item) async {
    if (_player.audioSource != null && item.id == mediaItem.value?.id) return;

    mediaItem.add(item);
    await _player.setAudioSource(AudioSource.asset(path));
    await _player.play();
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [MediaControl.pause, MediaControl.stop],
      playing: _player.playing,
      updatePosition: _player.position,
      processingState: AudioProcessingState.ready,
      systemActions: const {
        MediaAction.play,
        MediaAction.seek,
        MediaAction.pause,
        MediaAction.stop,
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
}
