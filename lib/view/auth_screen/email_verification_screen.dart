import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/guards/user_guards_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/auth_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatelessWidget {

  UserGuardsController userGuardsController = Get.put(UserGuardsController());

  // final User? user = FirebaseAuth.instance.currentUser;

  Future<void> sendEmailVerification(BuildContext context) async {
    if (userGuardsController.user.currentUser != null && !userGuardsController.user.currentUser!.emailVerified) {
      await userGuardsController.user.currentUser!.sendEmailVerification();

      // Show a dialog or navigate to inform the user to check their email
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Verification Email Sent', style: TextStyle(color: Colors.black)),
            content: Text(
              'A verification email has been sent to ${userGuardsController.user.currentUser!.email}. Please check your email to verify your account.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.to(SignInScreen());
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 220, 220, 1),
      ),
            backgroundColor: Color.fromRGBO(255, 253, 208, 1),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await sendEmailVerification(context);
          },
          child: Text('Send Verification Email'),
        ),
      ),
    );
  }
}