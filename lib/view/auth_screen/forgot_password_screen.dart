import 'package:aplikasi_kesehatan_mental_anak_remaja/view/auth_screen/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController _emailController = TextEditingController();


  Future<void> _resetPassword() async {
    try {
      if (_emailController.text.isNotEmpty) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text);
        Get.dialog(AlertDialog(
          title: const Text('Password Reset Email Sent'),
          content: const Text(
              'Check your email for instructions to reset your password.'),
          actions: [
            TextButton(
              onPressed: () {
                Get.to(SignInScreen());
              },
              child: const Text('OK'),
            ),
          ],
        ));
      } else {
        Get.dialog(const Text('Please fill your email'));
      }
    } catch (e) {
      Get.dialog(AlertDialog(
        title: const Text('Error'),
        content: Text(e.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(5, 15, 47, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              onPressed: _resetPassword,
              child: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
