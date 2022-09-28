import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

AudioPlayerHandler? audioHandler;

/// An [AudioHandler] for playing a single item.
class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  AudioPlayer _player = AudioPlayer(userAgent: "AppAudioPlayer");

  /// Initialise our audio handler in [AudioPlayerHandler].
  AudioPlayerHandler({required MediaItem item, required int duration}) {
    _player.stop();
    _player = AudioPlayer(userAgent: "AppAudioPlayer");

    // So that our clients (the Flutter UI and the system notification) know
    // what state to display, here we set up our audio handler to broadcast all
    // playback state changes as they happen via playbackState...
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    // ... and also the current media item via mediaItem.
    mediaItem.add(item);

    String filePath = "file:${item.id}";

    // Load the player.

    _player.setAudioSource(AudioSource.uri(Uri.parse(item.id)),
        initialPosition: Duration(milliseconds: duration));
  }

  // Any button press from the Flutter UI, notification, lock screen or
  // headset will be routed through to these 4 methods so that you can handle
  // your audio playback logic in one place.

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> setSpeed(double speed) => _player.setSpeed(speed);

  bool isPlaying() => _player.playing;

  Duration? getDuration() => _player.duration;

  Duration? getPosition() => _player.position;

  /// Transform a just_audio event into an audio_service state.
  ///
  /// This method is used from the constructor. Every event received from the
  /// just_audio player will be transformed into an audio_service state so that
  /// it can be broadcast to audio_service clients.
  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        const MediaControl(
          androidIcon: 'drawable/ic_player_back_play',
          label: 'Rewind',
          action: MediaAction.rewind,
        ),
        // MediaControl.rewind,
        _player.playing
            ? MediaControl(
                androidIcon: 'drawable/ic_pause',
                label: 'Play',
                action: MediaAction.play,
              )
            : MediaControl(
                androidIcon: 'drawable/ic_play',
                label: 'Pause',
                action: MediaAction.rewind,
              ),
        const MediaControl(
          androidIcon: 'drawable/ic_player_next_play',
          label: 'FastForward',
          action: MediaAction.fastForward,
        ),
        // MediaControl.fastForward,
        MediaControl.stop,
        // MediaControl.rewind,
        // const MediaControl(
        //   androidIcon: 'drawable/ic_player_back_play',
        //   label: 'Rewind',
        //   action: MediaAction.rewind,
        // ),
        // if (_player.playing)
        //   const MediaControl(
        //     androidIcon: 'drawable/ic_pause',
        //     label: 'Pause',
        //     action: MediaAction.pause,
        //   )
        // else
        //   const MediaControl(
        //     androidIcon: 'drawable/ic_play',
        //     label: 'Play',
        //     action: MediaAction.play,
        //   ),
        // //drawable
        // MediaControl.stop,
        // // MediaControl(action: ,androidIcon: ,label: "")
        //
        // const MediaControl(
        //   androidIcon: 'drawable/ic_player_next_play',
        //   label: 'Rewind',
        //   action: MediaAction.fastForward,
        // )
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.stop,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}
