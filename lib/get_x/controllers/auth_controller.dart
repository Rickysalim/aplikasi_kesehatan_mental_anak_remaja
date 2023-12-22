import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/repository/authentication_repository_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/utils/exceptions/signin_exception.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/utils/exceptions/signup_exception.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
 
  final authRepoController = Get.put(AuthenticationRepositoryController());

  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  /* 
    final phoneNumber = TextEditingController();
    final photoUrl = TextEditingController();
  */

  void resetText() {

    email.clear();
    username.clear();
    password.clear();
    confirmPassword.clear();
  }


  Future<void> register() async {
    try{
      await authRepoController.createUserWithEmailAndPassword(email.text, password.text, username.text);
      resetText();
    } on SignUpWithEmailAndPasswordFailureException catch (e) {
       Get.snackbar(e.code, e.message);
    }
  }

  Future<void> logout() async {
    try{
      await authRepoController.signOut();
    } catch(e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> login() async {
    try{
      await authRepoController.signInWithEmailAndPassword(email.text, password.text);
      resetText();
    } on SignInWithEmailAndPasswordFailureException catch (e) {
        Get.snackbar(e.code, e.message);
    }
  }
}

