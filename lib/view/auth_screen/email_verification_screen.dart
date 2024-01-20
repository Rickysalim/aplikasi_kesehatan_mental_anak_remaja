import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/auth_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/guards/user_guards_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/auth_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatelessWidget {
  EmailVerificationScreen({super.key});

  final userGuardsController = Get.put(UserGuardsController());

  final authController = Get.put(AuthController());

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      if (userGuardsController.user.currentUser != null &&
          !userGuardsController.user.currentUser!.emailVerified) {
        await userGuardsController.user.currentUser!.sendEmailVerification();

        Get.dialog(AlertDialog(
            title: const Text('Verification Email Sent',
                style: TextStyle(color: Colors.black)),
            content: Text(
              'A verification email has been sent to ${userGuardsController.user.currentUser!.email}. Please check your email to verify your account.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.to(SignInScreen());
                },
                child: const Text('OK'),
              ),
            ]));
      }
    } catch (e) {
      await authController.logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromRGBO(5, 15, 47, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          onPressed: () async => await sendEmailVerification(context),
          child: const Text('Send Verification Email'),
        ),
      ),
    );
  }
}
