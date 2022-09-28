import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as RX;
import 'package:seaweed/constant/app_string.dart';
import 'package:seaweed/constant/request_const.dart';
import 'package:seaweed/models/seaweed_data_model.dart';
import 'package:seaweed/services/audio_service.dart';
import 'package:seaweed/ui/widgets/custom_seekbar.dart';
import 'package:seaweed/utils/route_manager.dart';

class AudioPlayerController extends GetxController {
  RxBool isSelectedPost = false.obs;
  Duration audioPlayerTotalDuration = const Duration(seconds: 0);
  Duration audioDuration = const Duration(seconds: 0);
  Duration audioPosition = Duration.zero;
  RxBool isLoading = false.obs;
  PostData? postData;
  String image = "";
  String audioFile = "";

  @override
  void onInit() {
    super.onInit();
  }

  playAudio({required PostData postData}) async {
    clearAudio();
    isLoading.value = true;
    postData = postData;
    audioFile = "${AppUrls.audioFilePath}${postData.audioFile}";
    image = "";

    update();
    Get.toNamed(Routes.audioPlayerScreen, arguments: postData);
    Duration? audioDuration = await _getAudioDuration(audioFile);

    if (audioHandler != null) {
      List<Map<String, String>> playlist = [];
      final mediaItems = playlist
          .map((postData) => MediaItem(
                id: audioFile,
                album: "album",
                title: "n",
              ))
          .toList();
      audioHandler!.addQueueItems(mediaItems);
      audioHandler = AudioPlayerHandler(
          duration: 2,
          item: MediaItem(
            id: audioFile,
            album: "album",
            title: postData.name,
            artist: "The Seaweed Center",
            artUri: Uri.parse(""),
            duration: audioDuration,
          ));
    } else {
      audioHandler = await AudioService.init(
        builder: () => AudioPlayerHandler(
            duration: 2,
            item: MediaItem(
              id: audioFile,
              album: "album",
              title: postData.name,
              artist: "The Seaweed Center",
              artUri: Uri.parse(""),
              duration: audioDuration,
            )),
        config: AudioServiceConfig(
          androidNotificationChannelName: notificationChannelName,
          androidNotificationOngoing: true,
        ),
      );
    }

    await audioHandler!.play();
    await audioHandler!.pause();

    isLoading.value = false;
    update();
  }

  Stream<Duration> get _bufferedPositionStream => audioHandler!.playbackState
      .map((state) => state.bufferedPosition)
      .distinct();

  Stream<Duration?> get _durationStream => audioHandler!.mediaItem.map((item) {
        return item?.duration;
      }).distinct();

  Stream<PositionData>? get positionDataStream =>
      RX.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          AudioService.position, _bufferedPositionStream, _durationStream,
          (position, bufferedPosition, duration) {
        return PositionData(
            position, bufferedPosition, duration ?? Duration.zero);
      });

  resumeAudio() async {
    await audioHandler!.play();
    update();
  }

  audioDataGet({required PostData postDataForPlay}) async {
    audioHandler = null;
    playAudio(postData: postDataForPlay);
  }

  pauseAudio() async {
    await audioHandler!.pause();
    update();
  }

  stopAudio() async {
    await audioHandler!.stop();
    audioHandler = null;

    update();
  }

  Future skipForward() async {
    audioHandler!
        .seek(Duration(milliseconds: audioPosition.inMilliseconds + (10000)));
    update();
  }

  Future replay() async {
    audioHandler!.seek(Duration(seconds: 0));
    update();
  }

  Future skipBackward() async {
    if (audioPosition.inSeconds > 10) {
      audioHandler!
          .seek(Duration(milliseconds: audioPosition.inMilliseconds - (10000)));
    }
    update();
  }

  /// [clearAudio] Function Stop Previous Audio and play new audio.
  clearAudio() async {
    if (audioHandler != null) {
      audioHandler!.stop();
      audioHandler = null;
      if (postData!.audioFile != null) {
        MediaItem? mediaItem =
            await audioHandler!.getMediaItem(postData!.audioFile);
        if (mediaItem != null) {
          audioHandler!.removeQueueItem(mediaItem);
        }
      }
    }
    audioHandler = null;
  }

  Future<Duration?> _getAudioDuration(String url) async {
    final player = AudioPlayer(userAgent: "Demo");
    try {
      return await player.setUrl(url);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
