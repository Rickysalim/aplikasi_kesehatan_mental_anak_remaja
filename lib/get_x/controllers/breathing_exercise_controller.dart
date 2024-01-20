import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SessionState {
  initial,
  starting,
  holdBreathIn,
  holdBreathOut,
  breathingIn,
  breathingOut,
  ended,
  invalid
}


class BreatheSession {
  late int inBreaths; 
  late int outBreaths; 
  late double sessionLengthSeconds;
}

class TimerModel {
  final RxList<ValueChanged<ElapsedTime>> timerListeners =
      RxList(<ValueChanged<ElapsedTime>>[]);
  final Rx<TextStyle> textStyle =
      Rx(const TextStyle(fontSize: 90.0, fontFamily: "Bebas Neue"));
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

class BreathingExerciseController extends GetxController {
  static BreathingExerciseController get instance => Get.find();

  Rx<TimerModel> dependencies = Rx<TimerModel>(TimerModel());
  Rx<Timer?> timer = Rx<Timer?>(null);
  late RxInt milliseconds = RxInt(0);
  RxInt minutes = RxInt(0);
  RxInt seconds = RxInt(0);
  Rx<SessionState> sessionState = Rx<SessionState>(SessionState.initial);
  RxInt countDown = RxInt(0);
  Rx<Timer?> countDownTimer = Rx<Timer?>(null);
  Rx<Duration> oneSec = Rx<Duration>(const Duration(seconds: 1));

  void onTick(ElapsedTime elapsed) {
    if (elapsed.minutes != minutes.value || elapsed.seconds != seconds.value) {
      minutes.value = elapsed.minutes;
      seconds.value = elapsed.seconds;
    }
  }

  @override
  void onInit() {
    timer.value = Timer.periodic(
        Duration(milliseconds: dependencies.value.timerMillisecondsRefreshRate.value),
        callback);
    dependencies.value.timerListeners.add(onTick);
    super.onInit();
  }

  void resetAll() {
     dependencies.value.stopwatch.value.reset();
    milliseconds.value = 0;
    minutes.value = 0;
    seconds.value = 0;
    sessionState.value = SessionState.initial;
    countDown.value = 0;
    countDownTimer.value?.cancel();
    countDownTimer.value = null;
    Get.back();
  }

  void callback(Timer timer) {
    if (milliseconds.value != dependencies.value.stopwatch.value.elapsedMilliseconds) {
      milliseconds.value = dependencies.value.stopwatch.value.elapsedMilliseconds;
      final RxInt hundreds = RxInt((milliseconds.value / 10).truncate());
      final RxInt seconds = RxInt((hundreds.value / 100).truncate());
      final RxInt minutes = RxInt((seconds.value / 60).truncate());
      final ElapsedTime elapsedTime =
          ElapsedTime(seconds: seconds.value, minutes: minutes.value);
      for (final listener in dependencies.value.timerListeners) {
        listener(elapsedTime);
      }
    }
  }

  void start() {
    dependencies.value.stopwatch.value.start();
    beginExcerciseRoutine();
  }

  void stop() {
    dependencies.value.stopwatch.value.stop();
    sessionState.value = SessionState.ended;
    countDownTimer.value!.cancel();
    countDown.value = 0;
  }

  void beginExcerciseRoutine() {
    sessionState.value = nextState(sessionState.value);
    countDown.value = 5;
    countDownTimer.value = Timer.periodic(oneSec.value, (timer) {
      countDown.value--;
      if (countDown.value < 0) {
        countDown.value = 5;
        sessionState.value = nextState(sessionState.value);
      }
    });
  }

  SessionState nextState(SessionState state) {
    SessionState next;
    switch (state) {
      case SessionState.initial:
        next = SessionState.starting;
        break;
      case SessionState.starting:
        next = SessionState.breathingIn;
        break;
      case SessionState.breathingIn:
        next = SessionState.holdBreathIn;
        break;
      case SessionState.breathingOut:
        next = SessionState.holdBreathOut;
        break;
      case SessionState.holdBreathIn:
        next = SessionState.breathingOut;
        break;
      case SessionState.holdBreathOut:
        next = SessionState.breathingIn;
        break;
      case SessionState.ended:
        next = SessionState.ended;
        break;
      default:
        next = SessionState.invalid;
        break;
    }
    return next;
  }

  String instructionText(SessionState state) {
    RxString text = RxString("");
    switch (state) {
      case SessionState.initial:
        text.value = "Press Play to Begin";
        break;
      case SessionState.starting:
        text.value = "Get Ready...";
        break;
      case SessionState.breathingIn:
        text.value = "Breathe in Slowly";
        break;
      case SessionState.breathingOut:
        text.value = "Breathe out Slowly";
        break;
      case SessionState.holdBreathIn:
      case SessionState.holdBreathOut:
        text.value = "Hold";
        break;
      case SessionState.ended:
        text.value = "Great Job!";
        break;
      default:
        text.value = "INVALID STATE";
        break;
    }
    return text.value;
  }
}
