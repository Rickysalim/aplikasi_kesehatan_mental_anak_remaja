import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/auth_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/CrisisSupport.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/user_screen/crisis_support_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/user_screen/diagnose_history_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/user_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  static const String id = "setting_screen";

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color.fromRGBO(255, 253, 208, 1),
              Color.fromRGBO(255, 255, 255, 1),
            ])),
        child: ListView(padding: EdgeInsets.all(10), children: <Widget>[
          Padding(
              padding: EdgeInsets.all(5),
              child: Column(children: [
              Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 220, 220, 1),
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () => Get.to(DiagnoseHistoryScreen()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Diagnose History',
                                style: TextStyle(
                                    fontFamily: 'MochiyPopOne',
                                    fontSize: 20,
                                    color: Colors.black)),
                          )),
                        ],
                      )),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 220, 220, 1),
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () => Get.to(ProfileScreen()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Profile',
                                style: TextStyle(
                                    fontFamily: 'MochiyPopOne',
                                    fontSize: 20,
                                    color: Colors.black)),
                          )),
                        ],
                      )),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 220, 220, 1),
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async => await authController.logout(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text('Sign Out',
                                    style: TextStyle(
                                        fontFamily: 'MochiyPopOne',
                                        fontSize: 20,
                                        color: Colors.black))),
                          ),
                        ],
                      )),
                ),
                 Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(255, 220, 220, 1),
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () => Get.to(CrisisSupportScreen()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text('Consultation',
                                    style: TextStyle(
                                        fontFamily: 'MochiyPopOne',
                                        fontSize: 20,
                                        color: Colors.black))),
                          ),
                        ],
                      )),
                ),
              ])),
        ]),
      ),
    );
  }
}
