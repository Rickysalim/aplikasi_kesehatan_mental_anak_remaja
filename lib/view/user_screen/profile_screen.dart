import 'dart:io';

import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/profile_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/guards/user_guards_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  static const String id = "profile_screen";

  final userGuardsController = Get.put(UserGuardsController());

  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: profileController,
        builder: (controller) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
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
                      padding: const EdgeInsets.all(5),
                      child: Column(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 50),
                              controller.imageFile.value != null ||
                                      controller.usernameController.value.text !=
                                          ""
                                  ? CircleAvatar(
                                      radius: 100,
                                      backgroundColor: Colors.brown,
                                      backgroundImage: FileImage(File(controller
                                          .imageFile.value!.path
                                          .toString())),
                                      child: Text(controller.usernameController.value.text,
                                          style: const TextStyle(
                                              color: Colors.white)))
                                  : CircleAvatar(
                                      radius: 100,
                                      backgroundColor: Colors.brown,
                                      backgroundImage: NetworkImage(
                                          userGuardsController
                                              .user.currentUser!.photoURL
                                              .toString()),
                                      child: Text(
                                          userGuardsController.user.currentUser!.displayName.toString(),
                                          style: const TextStyle(color: Colors.white))),
                              Text(
                                  userGuardsController
                                      .user.currentUser!.displayName!
                                      .toString(),
                                  style: const TextStyle(
                                      fontFamily: 'OdorMeanChey',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Text(
                                  userGuardsController.user.currentUser!.email!
                                      .toString(),
                                  style: const TextStyle(
                                      fontFamily: 'OdorMeanChey',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              const SizedBox(height: 50),
                              const Divider(),
                              Form(
                                  key: controller.formKeyUpdateProfile.value,
                                  child: Column(children: [
                                    Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  fixedSize:
                                                      const Size(100, 50),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          255, 220, 220, 1)),
                                              onPressed: controller.pickImage,
                                              child: const Text('Pick Image',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'OdorMeanChey',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                            ))),
                                    Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                          readOnly: true,
                                          initialValue: userGuardsController
                                              .user.currentUser!.uid,
                                          decoration: InputDecoration(
                                            labelText: 'User UID',
                                            labelStyle: const TextStyle(
                                                fontFamily: 'OdorMeanChey',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            filled: true,
                                            fillColor: const Color.fromRGBO(
                                                255, 220, 220, 1),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: TextFormField(
                                          controller: controller
                                              .usernameController.value,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Username',
                                            labelStyle: const TextStyle(
                                                fontFamily: 'OdorMeanChey',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            filled: true,
                                            fillColor: const Color.fromRGBO(
                                                255, 220, 220, 1),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  fixedSize:
                                                      const Size(100, 50),
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          255, 220, 220, 1)),
                                              onPressed: () async {
                                                if (controller
                                                    .formKeyUpdateProfile
                                                    .value
                                                    .currentState!
                                                    .validate()) {
                                                  await controller
                                                      .updateUserProfile();
                                                }
                                              },
                                              child: const Text(
                                                  'Update Profile',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'OdorMeanChey',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                            ))),
                                    const Divider(),
                                  ]))
                            ]),
                      ]))
                ],
              ),
            ),
          );
        });
  }
}
