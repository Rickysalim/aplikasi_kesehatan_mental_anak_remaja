import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProfileScreen extends StatefulWidget {
  static const String id = "profile_screen";

  @override
  _ProfileScreenScreenState createState() => _ProfileScreenScreenState();
}

class _ProfileScreenScreenState extends State<ProfileScreen> {
   
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color.fromRGBO(77, 67, 187, 1),
              Color.fromRGBO(255, 255, 255, 1),
            ])),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(children: [
                            IconButton(
                              iconSize: 40,
                              color: Colors.white,
                              icon: Icon(Icons.arrow_back),
                              onPressed: () => Get.back()
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child:
                                  Image.asset('assets/images/icon-small.png'),
                            ),
                          ])),
                      Padding(
                          padding: EdgeInsets.all(30),
                          child: Text('Profile',
                              style: TextStyle(
                              fontFamily: 'MochiyPopOne',
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ]),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(children: [
                    SizedBox(height: 50),
                    Container(
                        height: 200,
                        width: 200,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/gg_profile.png'),
                          backgroundColor: Colors.transparent,
                          child: const Text(''),
                        )),
                    Text('Esa Unggul',
                        style: TextStyle(
                              fontFamily: 'MochiyPopOne',
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ]),
                  SizedBox(height: 50),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: "Test",
                        decoration: InputDecoration(
                          labelText: 'username',
                          filled: true,
                          fillColor: Color.fromRGBO(255, 220, 220, 1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor: Color.fromRGBO(255, 220, 220, 1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          fillColor: Color.fromRGBO(255, 220, 220, 1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        readOnly: true,
                        obscureText: true,
                      )),
                ])
              ]),
            )
          ],
        ),
      ),
    );
  }
}
