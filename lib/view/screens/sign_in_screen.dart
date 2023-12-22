import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/auth_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignInScreen extends StatefulWidget {
  static const String id = "sign_in_screen";

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  AuthController authController = Get.put(AuthController());
  
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  AuthController signInController = Get.put(AuthController());

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(77, 67, 187, 1),
        ),
        child: ListView(
          children: <Widget>[
            Image.asset('assets/images/icon.png',
                width: 150, height: 150), // Ganti dengan gambar yang diinginkan
            Align(
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
                    padding: EdgeInsets.all(20),
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
                    padding: EdgeInsets.all(20),
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
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      child: Text('Sign In',
                          style: TextStyle(
                              fontFamily: 'MochiyPopOne',color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await authController.login();
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
                    padding: EdgeInsets.all(20),
                    child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Need to create an account? ',
                                style: TextStyle(
                              fontFamily: 'MochiyPopOne',
                                    color: Colors.white)),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(5, 15, 47, 1),
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  )),
                              onPressed: () => Get.to(SignUpScreen()),
                              child: Text('Sign Up',
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
