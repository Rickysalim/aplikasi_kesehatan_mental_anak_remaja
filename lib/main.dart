import 'package:aplikasi_kesehatan_mental_anak_remaja/firebase/firebase_options.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/guards/splash_screen_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/guards/user_guards_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) { 
    Get.put(UserGuardsController());
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
          backgroundColor: Color.fromRGBO(77, 67, 187, 1),
          body: Align(
              alignment: Alignment.center,
              child: Text('LOADING',
                  style: TextStyle(
                      fontFamily: 'Barriecito',
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 48)))),
    );
  }
}
