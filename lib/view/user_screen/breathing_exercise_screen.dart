import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/breathing_exercise_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BreatheExcerciseScreen extends StatelessWidget {
  final breathingExerciseController = Get.put(BreathingExerciseController());

  BreatheExcerciseScreen({super.key});

  Widget actionButton(
      SessionState state, BreathingExerciseController controller) {
    if (state == SessionState.initial) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.yellow.shade900,
          onPressed: controller.start,
          child: const Icon(Icons.play_arrow),
        ),
      );
    } else if (state == SessionState.ended) {
      return FloatingActionButton(
          backgroundColor: Colors.yellow.shade900,
          onPressed: () {
            controller.resetAll();
          },
          child: const Icon(Icons.arrow_back));
    } else {
      return FloatingActionButton(
          backgroundColor: Colors.yellow.shade900,
          onPressed: controller.stop,
          child: const Icon(Icons.stop));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX<BreathingExerciseController>(
        init: breathingExerciseController,
        builder: (controller) {
          String minutesStr =
              (controller.minutes.value % 60).toString().padLeft(2, '0');
          String secondsStr =
              (controller.seconds.value % 60).toString().padLeft(2, '0');
          return Scaffold(
            backgroundColor: const Color.fromRGBO(255, 253, 208, 1),
            body: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      RepaintBoundary(
                        child: SizedBox(
                          height: 90.0,
                          child: Text('$minutesStr:$secondsStr',
                              style: controller
                                  .dependencies.value.textStyle.value),
                        ),
                      )
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        controller
                            .instructionText(controller.sessionState.value),
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          '${controller.countDown.value}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ))
                  ],
                )),
            floatingActionButton:
                actionButton(controller.sessionState.value, controller),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        });
  }
}
