

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerModel {
  final RxList<ValueChanged<ElapsedTime>> timerListeners =
      RxList(<ValueChanged<ElapsedTime>>[]);
  final Rx<TextStyle> textStyle = Rx(TextStyle(fontSize: 90.0, fontFamily: "Bebas Neue"));
  final Rx<Stopwatch> stopwatch = Rx(Stopwatch());
  final RxInt timerMillisecondsRefreshRate = RxInt(30);
}

class ElapsedTime {
  final int seconds;
  final int minutes;

  ElapsedTime({
    required this.seconds,
    required this.minutes,
  });
}