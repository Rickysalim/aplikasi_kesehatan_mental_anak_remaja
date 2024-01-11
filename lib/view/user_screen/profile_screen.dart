import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/guards/user_guards_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProfileScreen extends StatelessWidget {
  static const String id = "profile_screen";

  UserGuardsController userGuardsController = Get.put(UserGuardsController());

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
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(children: [
                            IconButton(
                              iconSize: 40,
                              color: Colors.black,
                              icon: Icon(Icons.arrow_back),
                              onPressed: () => Get.back()
                            ),
                          ])),

                    ]),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(height: 50),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: userGuardsController.user.currentUser!.displayName.toString(),
                        decoration: InputDecoration(
                          labelText: 'username',
                          filled: true,
                          fillColor: Color.fromRGBO(255, 220, 220, 1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: userGuardsController.user.currentUser!.email,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor: Color.fromRGBO(255, 220, 220, 1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: userGuardsController.user.currentUser!.uid,
                        decoration: InputDecoration(
                          labelText: 'User UID',
                          filled: true,
                          fillColor: Color.fromRGBO(255, 220, 220, 1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      )),
                ])
              ]),
            )
          ],
        ),
      ),
    );
  }
}
