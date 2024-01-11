import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/auth_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/auth_screen/sign_in_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/auth_screen/email_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = "sign_up_screen";
 
  final _formKey = GlobalKey<FormState>();

  AuthController signUpController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(children: <Widget>[
              Image.asset('assets/images/people.jpg',
                width: 300, height: 300), 
              Align(
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
                        padding: EdgeInsets.all(10),
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
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your email';
                            }
                            return null;
                          },
                          controller: signUpController.email,
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
                        padding: EdgeInsets.all(10),
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
                        padding: EdgeInsets.all(10),
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
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                          child: Text('Sign Up',
                              style: TextStyle(
                                  fontFamily: 'MochiyPopOne',
                                  color: Colors.white)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await signUpController.register().then((value) => {
                                Get.to(EmailVerificationScreen())
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(5, 15, 47, 1),
                            onPrimary: Colors.black,
                            minimumSize: Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account? ',
                                  style: TextStyle(
                                      fontFamily: 'MochiyPopOne',
                                      color: Colors.black)),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(5, 15, 47, 1),
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    )),
                                onPressed: () => Get.to(SignInScreen()),
                                child: Text('Sign In',
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
