import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SessionState {
  Initial,
  Starting,
  HoldBreathIn,
  HoldBreathOut,
  BreathingIn,
  BreathingOut,
  Ended,
  Invalid
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
      Rx(TextStyle(fontSize: 90.0, fontFamily: "Bebas Neue"));
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
  Rx<SessionState> sessionState = Rx<SessionState>(SessionState.Initial);
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
    sessionState.value = SessionState.Initial;
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
    sessionState.value = SessionState.Ended;
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
      case SessionState.Initial:
        next = SessionState.Starting;
        break;
      case SessionState.Starting:
        next = SessionState.BreathingIn;
        break;
      case SessionState.BreathingIn:
        next = SessionState.HoldBreathIn;
        break;
      case SessionState.BreathingOut:
        next = SessionState.HoldBreathOut;
        break;
      case SessionState.HoldBreathIn:
        next = SessionState.BreathingOut;
        break;
      case SessionState.HoldBreathOut:
        next = SessionState.BreathingIn;
        break;
      case SessionState.Ended:
        next = SessionState.Ended;
        break;
      default:
        next = SessionState.Invalid;
        break;
    }
    return next;
  }

  String instructionText(SessionState state) {
    RxString text = RxString("");
    switch (state) {
      case SessionState.Initial:
        text.value = "Press Play to Begin";
        break;
      case SessionState.Starting:
        text.value = "Get Ready...";
        break;
      case SessionState.BreathingIn:
        text.value = "Breathe in Slowly";
        break;
      case SessionState.BreathingOut:
        text.value = "Breathe out Slowly";
        break;
      case SessionState.HoldBreathIn:
      case SessionState.HoldBreathOut:
        text.value = "Hold";
        break;
      case SessionState.Ended:
        text.value = "Great Job!";
        break;
      default:
        text!.value = "INVALID STATE";
        break;
    }
    return text!.value;
  }
}
