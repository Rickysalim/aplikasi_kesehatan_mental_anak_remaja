import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/guards/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  static const String id = "";

  SplashScreenController splashScreenController =
      Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return GetX<SplashScreenController>(
        init: splashScreenController,
        builder: (controller) {
          return Scaffold(
              body: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: Image.asset('assets/images/people.jpg')),
                        Container(
                            margin: EdgeInsets.all(45),
                            child: controller.isLoading.value
                                ? Text('APLIKASI KESEHATAN MENTAL ANAK REMAJA',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Barriecito',
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: 48))
                                : Container(
                                    margin: EdgeInsets.only(top: 50),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Color.fromRGBO(255, 253, 208, 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        onPressed: () async =>
                                            await splashScreenController
                                                .setIsViewed(1),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 50,
                                              right: 50,
                                              top: 10,
                                              bottom: 10),
                                          child: Text(
                                            'GET STARTED',
                                            style: TextStyle(
                                                fontFamily: 'MochiyPopOne',
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ))))
                      ])));
        });
  }
}
