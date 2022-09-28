import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seaweed/models/seaweed_data_model.dart';
import 'package:seaweed/services/audio_service.dart';
import 'package:seaweed/theme/app_assets.dart';
import 'package:seaweed/theme/app_colors.dart';
import 'package:seaweed/ui/screens/main/audio_player_screen/audio_player_controller.dart';
import 'package:seaweed/ui/widgets/custom_seekbar.dart';
import 'package:seaweed/utils/extension.dart';

class AudioPlayerScreen extends StatelessWidget {
  AudioPlayerScreen({Key? key}) : super(key: key);

  AudioPlayerController audioPlayerController =
      Get.find<AudioPlayerController>();

  @override
  Widget build(BuildContext context) {
    PostData postData = Get.arguments;
    String tital = postData.name;
    return Scaffold(
      backgroundColor: appGrayBgColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: appBlack,
              size: 30,
            )),
        backgroundColor: appWhite,
        title: postData != null
            ? Text(
                tital,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: appTextStyleSifonFont(
                    color: appBlack,
                    fontWeight: FontWeight.w700,
                    fontSize: Get.height * 0.022),
              )
            : SizedBox(),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: GetBuilder<AudioPlayerController>(builder: (ctrl) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: appWhite, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  (Get.height * 0.030).addHSpace(),
                  Container(
                    height: Get.height / 6,
                    width: Get.width,
                    decoration: BoxDecoration(
                      border: Border.all(width: 10, color: appColor),
                    ),
                    child: Image.asset(
                      ImageAsstes.img_player_demo,
                      fit: BoxFit.fill,
                    ),
                  ).paddingSymmetric(horizontal: 70),
                  (Get.height * 0.030).addHSpace(),
                  audioHandler != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: StreamBuilder<PositionData>(
                            stream: ctrl.positionDataStream,
                            builder: (context, snapshot) {
                              final positionData = snapshot.data ??
                                  PositionData(Duration.zero, Duration.zero,
                                      Duration.zero);
                              ctrl.audioDuration = positionData.duration;
                              ctrl.audioPosition = positionData.position;

                              return SeekBar2(
                                duration: positionData.duration,
                                position: positionData.position,
                                bufferedPosition: positionData.bufferedPosition,
                                onChangeEnd: (newPosition) {
                                  audioHandler?.seek(newPosition);
                                },
                              );
                            },
                          ),
                        )
                      : SeekBar2(
                          duration: Duration(seconds: 0),
                          position: Duration(seconds: 0),
                          bufferedPosition: Duration(seconds: 0),
                          onChangeEnd: (newPosition) {},
                        ).paddingSymmetric(horizontal: 16),
                  (Get.height * 0.040).addHSpace(),
                  audioHandler != null
                      ? StreamBuilder<PlaybackState>(
                          stream: audioHandler!.playbackState,
                          builder: (context, snapshot) {
                            final playbackState = snapshot.data;
                            final processingState =
                                playbackState?.processingState;
                            final playing = playbackState?.playing;
                            if (processingState ==
                                    AudioProcessingState.loading ||
                                processingState ==
                                    AudioProcessingState.buffering) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    ImageIcons.ic_player_suffle,
                                    height: 20,
                                    width: 20,
                                  ),
                                  _getBackwardButton(false),
                                  const CircularProgressIndicator(
                                    color: appColor,
                                  ),
                                  _getForwardButton(false),
                                  _getReplayButton(false),
                                ],
                              ).paddingSymmetric(horizontal: 15);
                            } else {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    ImageIcons.ic_player_suffle,
                                    height: 20,
                                    width: 20,
                                  ),
                                  _getBackwardButton(true),
                                  Visibility(
                                    visible: playing ?? false,
                                    child: InkWell(
                                      onTap: () {
                                        ctrl.pauseAudio();
                                      },
                                      child: const Icon(
                                        Icons.pause,
                                        size: 40,
                                        color: appColor,
                                      ),
                                    ),
                                    replacement: InkWell(
                                      onTap: () {
                                        ctrl.resumeAudio();
                                      },
                                      child: const Icon(
                                        Icons.play_arrow_rounded,
                                        size: 40,
                                        color: appColor,
                                      ),
                                    ),
                                  ),
                                  _getForwardButton(true),
                                  _getReplayButton(false),
                                ],
                              ).paddingSymmetric(horizontal: 15);
                            }
                          })
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              ImageIcons.ic_player_suffle,
                              height: 20,
                              width: 20,
                            ),
                            _getBackwardButton(false),
                            const CircularProgressIndicator(
                              color: appColor,
                            ),
                            _getForwardButton(false),
                            _getReplayButton(false),
                          ],
                        ).paddingSymmetric(horizontal: 15),
                  (Get.height * 0.040).addHSpace(),
                ],
              ),
            ).paddingOnly(top: 20, left: 20, right: 20, bottom: 40),
            Expanded(
                child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                  color: appColor,
                  border: Border.all(color: appColor, width: 20),
                  borderRadius: const BorderRadius.only(
                      topLeft: const Radius.circular(30),
                      topRight: const Radius.circular(30))),
              child: Container(
                decoration: BoxDecoration(
                    color: appWhite,
                    border: Border.all(color: appWhite, width: 20),
                    borderRadius: const BorderRadius.only(
                      topLeft: const Radius.circular(30),
                      topRight: const Radius.circular(30),
                      bottomRight: const Radius.circular(30),
                      bottomLeft: const Radius.circular(30),
                    )),
                child: Column(
                  children: [
                    (Get.height * 0.040).addHSpace(),
                    Text(
                      "Summary",
                      style: appTextStyleSifonFont(
                          color: appColor,
                          fontSize: Get.height * 0.030,
                          fontWeight: FontWeight.w700),
                    ),
                    (Get.height * 0.030).addHSpace(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              postData.summary,
                              style: appTextStyleOpenSensFont(
                                  color: appColor,
                                  fontSize: Get.height * 0.026,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ).paddingSymmetric(horizontal: 20),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
          ],
        );
      }),
    );
  }

  Widget _getBackwardButton(bool isClickable) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Image.asset(
          ImageIcons.ic_player_back_play,
          height: 20,
          width: 20,
        ),
      ),
      onTap: () async {
        if (isClickable) {
          audioPlayerController.skipBackward();
        }
      },
    );
  }

  _getForwardButton(bool isClickable) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Image.asset(
          ImageIcons.ic_player_next_play,
          height: 20,
          width: 20,
        ),
      ),
      onTap: () async {
        if (isClickable) {
          await audioPlayerController.skipForward();
        }
      },
    );
  }

  _getReplayButton(bool isClickable) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Image.asset(
          ImageIcons.ic_player_replay,
          height: 20,
          width: 20,
        ),
      ),
      onTap: () async {
        if (isClickable) {
          await audioPlayerController.replay();
        }
      },
    );
  }
}
