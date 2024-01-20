import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/auth_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/auth_screen/sign_in_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/auth_screen/email_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = "sign_up_screen";

  final _formKey = GlobalKey<FormState>();

  final signUpController = Get.put(AuthController());

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(children: <Widget>[
              Image.asset('assets/images/people.jpg', width: 300, height: 300),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Sign Up',
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
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your username';
                            }
                            return null;
                          },
                          controller: signUpController.username,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your email';
                            }
                            return null;
                          },
                          controller: signUpController.email,
                          keyboardType: TextInputType.emailAddress,
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
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your password';
                            }
                            return null;
                          },
                          controller: signUpController.password,
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
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your confirm password';
                            }
                            if (value != signUpController.password.text) {
                              return 'confirm password does not match';
                            }
                            return null;
                          },
                          controller: signUpController.confirmPassword,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          obscureText: true,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await signUpController.register().then((value) =>
                                  {Get.to(EmailVerificationScreen())});
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
                          child: const Text('Sign Up',
                              style: TextStyle(
                                  fontFamily: 'MochiyPopOne',
                                  color: Colors.white)),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account? ',
                                  style: TextStyle(
                                      fontFamily: 'MochiyPopOne',
                                      color: Colors.black)),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        const Color.fromRGBO(5, 15, 47, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    )),
                                onPressed: () => Get.to(SignInScreen()),
                                child: const Text('Sign In',
                                    style: TextStyle(
                                        fontFamily: 'MochiyPopOne',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ]))
                  ])),
            ])));
  }
}
