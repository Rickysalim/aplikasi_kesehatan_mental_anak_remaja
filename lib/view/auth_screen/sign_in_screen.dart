import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/auth_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/auth_screen/forgot_password_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/auth_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  static const String id = "sign_in_screen";

  final authController = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          children: <Widget>[
            Image.asset('assets/images/people.jpg', width: 300, height: 300),
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Sign In',
                        style: TextStyle(
                          fontFamily: 'MochiyPopOne',
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        )))),
            Form(
              key: _formKey,
              child: Column(children: [
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      controller: authController.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter your email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      controller: authController.password,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      obscureText: true,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Get.to(ForgotPasswordScreen());
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontFamily: 'MochiyPopOne',
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await authController.login();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color.fromRGBO(5, 15, 47, 1),
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Sign In',
                          style: TextStyle(
                              fontFamily: 'MochiyPopOne', color: Colors.white)),
                    )),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Need to create an account? ',
                            style: TextStyle(
                                fontFamily: 'MochiyPopOne',
                                color: Colors.black)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color.fromRGBO(5, 15, 47, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                          onPressed: () => Get.to(SignUpScreen()),
                          child: const Text('Sign Up',
                              style: TextStyle(
                                  fontFamily: 'MochiyPopOne',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ]),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
