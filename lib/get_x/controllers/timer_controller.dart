// import 'dart:async';
// import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Timer.dart';
// import 'package:get/get.dart';



// class TimerController extends GetxController {
//   static TimerController get instance => Get.find();

//   final TimerModel dependencies = TimerModel();
//   Rx<Timer?> timer = Rx<Timer?>(null);
//   late RxInt milliseconds = RxInt(0);

//   RxInt minutes = RxInt(0);
//   RxInt seconds = RxInt(0);

//   void onTick(ElapsedTime elapsed) {
//     if (elapsed.minutes != minutes.value || elapsed.seconds != seconds.value) {
//       minutes.value = elapsed.minutes;
//       seconds.value = elapsed.seconds;
//     }
//   }



//   @override
//   void onInit() {
//     timer.value = Timer.periodic(
//         Duration(milliseconds: dependencies.timerMillisecondsRefreshRate.value),
//         callback);
//     dependencies.timerListeners.add(onTick);
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     timer.value!.cancel();
//     timer.value = null;
//     super.onClose();
//   }

//   void callback(Timer timer) {
//     if (milliseconds.value != dependencies.stopwatch.value.elapsedMilliseconds) {
//       milliseconds.value = dependencies.stopwatch.value.elapsedMilliseconds;
//       final RxInt hundreds = RxInt((milliseconds.value / 10).truncate());
//       final RxInt seconds = RxInt((hundreds.value / 100).truncate());
//       final RxInt minutes = RxInt((seconds.value / 60).truncate());
//       final ElapsedTime elapsedTime =
//           ElapsedTime(seconds: seconds.value, minutes: minutes.value);
//       for (final listener in dependencies.timerListeners) {
//         listener(elapsedTime);
//       }
//     }
//   }
// }
