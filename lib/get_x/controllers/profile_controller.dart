import 'dart:io';

import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/guards/user_guards_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final userGuardsController = Get.put(UserGuardsController()); 

  final Rx<GlobalKey<FormState>> formKeyUpdateProfile =
      Rx<GlobalKey<FormState>>(GlobalKey<FormState>());

  final Rx<GlobalKey<FormState>> formKeyUpdateEmail =
      Rx<GlobalKey<FormState>>(GlobalKey<FormState>());

  final passwordController =
      Rx<TextEditingController>(TextEditingController());

  final usernameController =
      Rx<TextEditingController>(TextEditingController());

  final emailController =
      Rx<TextEditingController>(TextEditingController());

  Rx<PlatformFile?> imageFile = Rx<PlatformFile?>(null);

  // final user = FirebaseAuth.instance.currentUser!;

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      imageFile.value = result.files.first;
      update();
    }
  }
  
  Future<void> updateUserProfile() async {
    final profileRef = FirebaseStorage.instance
        .ref('uploads/images/profile/${usernameController.value.text}');

    if (imageFile.value != null) {
      ListResult oldProfileRef = await FirebaseStorage.instance
          .ref('uploads/images/profile/${usernameController.value.text}')
          .listAll();

      await Future.forEach(oldProfileRef.items, (Reference ref) async {
        await ref.delete();
      }).whenComplete(() => {}).catchError((e) {
        Get.snackbar("Error", "Error happen while Delete Picture");
      });

      final profileUrl = await profileRef.child(imageFile.value!.name).putFile(
          File(imageFile.value!.path.toString()),
          SettableMetadata(contentType: 'image/${imageFile.value!.extension}'));

      final getProfileUrl = await profileUrl.ref.getDownloadURL();

      await  userGuardsController.user.currentUser!.updateDisplayName(usernameController.value.text);
      await  userGuardsController.user.currentUser!.updatePhotoURL(getProfileUrl);
    }
  }
}
