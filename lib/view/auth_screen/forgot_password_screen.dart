import 'package:aplikasi_kesehatan_mental_anak_remaja/view/auth_screen/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _resetPassword() async {
    try {
      if (_emailController.text.isNotEmpty) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text);
        Get.dialog(AlertDialog(
          title: Text('Password Reset Email Sent'),
          content:
              Text('Check your email for instructions to reset your password.'),
          actions: [
            TextButton(
              onPressed: () {
                Get.to(SignInScreen());
              },
              child: Text('OK'),
            ),
          ],
        ));
      } else {
        Get.dialog(Text('Please fill your email'));
      }
    } catch (e) {
      print('Error sending reset email: $e');
      Get.dialog(AlertDialog(
        title: Text('Error'),
        content: Text(e.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('OK'),
          ),
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 220, 220, 1),
      ),
      backgroundColor: Color.fromRGBO(255, 253, 208, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetPassword,
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
