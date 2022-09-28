import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seaweed/theme/app_colors.dart';

class SeekBar2 extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  SeekBar2({
    required this.duration,
    required this.position,
    this.bufferedPosition = Duration.zero,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBar2State createState() => _SeekBar2State();
}

class _SeekBar2State extends State<SeekBar2> {
  double? _dragValue;
  bool _dragging = false;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final value = min(
      _dragValue ?? widget.position.inMilliseconds.toDouble(),
      widget.duration.inMilliseconds.toDouble(),
    );
    if (_dragValue != null && !_dragging) {
      _dragValue = null;
    }
    var durationTextSize = 14;
    return Column(
      children: [
        Stack(
          children: [
            SliderTheme(
              data: _sliderThemeData.copyWith(
                trackHeight: 4,
                thumbShape: HiddenThumbComponentShape(),
                activeTrackColor: Color(0xFFE7DDE0),
                inactiveTrackColor: Color(0xFFE7DDE0),
              ),
              child: ExcludeSemantics(
                child: Slider(
                  min: 0.0,
                  max: widget.duration.inMilliseconds.toDouble(),
                  value: min(widget.bufferedPosition.inMilliseconds.toDouble(),
                      widget.duration.inMilliseconds.toDouble()),
                  onChanged: (value) {},
                ),
              ),
            ),
            SliderTheme(
              data: _sliderThemeData.copyWith(
                trackHeight: Get.height * 0.005,
                thumbColor: appColor,
                activeTrackColor: appColor,
                inactiveTrackColor: Colors.transparent,
              ),
              child: Slider(
                min: 0.0,
                max: widget.duration.inMilliseconds.toDouble(),
                value: value,
                onChanged: (value) {
                  if (!_dragging) {
                    _dragging = true;
                  }
                  setState(() {
                    _dragValue = value;
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(Duration(milliseconds: value.round()));
                  }
                },
                onChangeEnd: (value) {
                  if (widget.onChangeEnd != null) {
                    widget.onChangeEnd!(Duration(milliseconds: value.round()));
                  }
                  _dragging = false;
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                        .firstMatch("$_start")
                        ?.group(1) ??
                    '$_start',
                textScaleFactor: Get.textScaleFactor,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, color: appColor)),
            Text(
                RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                        .firstMatch("$_remaining")
                        ?.group(1) ??
                    '$_remaining',
                textScaleFactor: Get.textScaleFactor,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, color: appColor)),
          ],
        ),
      ],
    );
  }

  // Duration get _remaining => widget.duration - widget.position;
  Duration get _remaining => widget.duration;

  Duration get _start => widget.position;
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {}
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

class SeekBarForVideo extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  SeekBarForVideo({
    required this.duration,
    required this.position,
    this.bufferedPosition = Duration.zero,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarForVideoState createState() => _SeekBarForVideoState();
}

class _SeekBarForVideoState extends State<SeekBarForVideo> {
  double? _dragValue;
  bool _dragging = false;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final value = min(
      _dragValue ?? widget.position.inMilliseconds.toDouble(),
      widget.duration.inMilliseconds.toDouble(),
    );
    if (_dragValue != null && !_dragging) {
      _dragValue = null;
    }
    var durationTextSize = 14;
    return Column(
      children: [
        Row(
          children: [
            Text(
                RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                        .firstMatch("$_start")
                        ?.group(1) ??
                    '$_start',
                textScaleFactor: Get.textScaleFactor,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, color: Colors.white)),
            Expanded(
              child: SizedBox(
                child: Stack(
                  children: [
                    SliderTheme(
                      data: _sliderThemeData.copyWith(
                        trackHeight: 5,
                        thumbShape: HiddenThumbComponentShape(),
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.white.withOpacity(0.5),
                      ),
                      child: ExcludeSemantics(
                        child: Slider(
                          min: 0.0,
                          max: widget.duration.inMilliseconds.toDouble(),
                          value: min(
                              widget.bufferedPosition.inMilliseconds.toDouble(),
                              widget.duration.inMilliseconds.toDouble()),
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    SliderTheme(
                      data: _sliderThemeData.copyWith(
                        trackHeight: Get.height * 0.005,
                        thumbColor: Color(0xFF20334B),
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.transparent,
                      ),
                      child: Slider(
                        min: 0.0,
                        max: widget.duration.inMilliseconds.toDouble(),
                        value: value,
                        onChanged: (value) {
                          if (!_dragging) {
                            _dragging = true;
                          }
                          setState(() {
                            _dragValue = value;
                          });
                          if (widget.onChanged != null) {
                            widget.onChanged!(
                                Duration(milliseconds: value.round()));
                          }
                        },
                        onChangeEnd: (value) {
                          if (widget.onChangeEnd != null) {
                            widget.onChangeEnd!(
                                Duration(milliseconds: value.round()));
                          }
                          _dragging = false;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
                RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                        .firstMatch("$_remaining")
                        ?.group(1) ??
                    '$_remaining',
                textScaleFactor: Get.textScaleFactor,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, color: Colors.white)),
          ],
        ).paddingSymmetric(horizontal: 5),
      ],
    );
  }

  // Duration get _remaining => widget.duration - widget.position;
  Duration get _remaining => widget.duration;

  Duration get _start => widget.position;
}
