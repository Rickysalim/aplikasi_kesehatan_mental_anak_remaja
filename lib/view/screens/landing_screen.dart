import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/auth_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/test_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/video_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/guards/user_guards_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Test.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Video.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/crisis_support_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/diagnose_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/test_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/setting_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/video_watch_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingScreen extends StatefulWidget {
  static const String id = "landing_screen";

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  AuthController authController = Get.put(AuthController());
  UserGuardsController userGuardsController = Get.put(UserGuardsController());
  VideoController videoController = Get.put(VideoController());
  TestController testController = Get.put(TestController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 100,
            title: Text(
                'Hi, ${userGuardsController.user.currentUser!.displayName ?? "Unknown"}',
                style: TextStyle(
                  fontFamily: 'MochiyPopOne',
                )),
            backgroundColor: const Color.fromRGBO(77, 67, 187, 1),
            // leading: Builder(builder: (BuildContext context) {
            //   return IconButton(
            //       onPressed: () {},
            //       icon: Image.asset(
            //         '',
            //       ));
            // }),
            actions: [
              TextButton(
                  onPressed: () async => await authController.logout(),
                  child: Text('Sign Out',
                      style: TextStyle(
                          fontFamily: 'MochiyPopOne', color: Colors.white)))
            ]),
        body: ListView(children: <Widget>[
          SizedBox(height: 10),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color.fromRGBO(116, 185, 215, 1)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Welcome to',
                              style: TextStyle(
                                  fontFamily: 'MochiyPopOne',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromRGBO(21, 0, 67, 1))),
                          Text('Apps!',
                              style: TextStyle(
                                  fontFamily: 'MochiyPopOne',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromRGBO(21, 0, 67, 1))),
                          Text('Let’s learn about mental',
                              style: TextStyle(
                                  fontFamily: 'MochiyPopOne',
                                  color: Color.fromRGBO(21, 0, 67, 1))),
                          Text('with us!',
                              style: TextStyle(
                                  fontFamily: 'MochiyPopOne',
                                  color: Color.fromRGBO(21, 0, 67, 1))),
                        ],
                      ),
                    ),
                    // Container(
                    //     child:
                    //         Image.asset(""),
                    //     height: 100,
                    //     width: 100)
                  ]),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('videos about mental health',
                              style: TextStyle(
                                  fontFamily: 'OdorMeanChey',
                                  fontWeight: FontWeight.bold)),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'See All',
                                style: TextStyle(
                                    fontFamily: 'OdorMeanChey',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(221, 56, 56, 1)),
                              ))
                        ]),
                  ),
                ],
              )),
          SizedBox(
            height: 150.0,
            child: StreamBuilder<List<Video>>(
              stream: videoController.getAllVideo(),
              builder: (context, snapshot) {
                List<Video>? video = snapshot.data;
                if (snapshot.hasData) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: video!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        video![index].video_caption_url != null
                                            ? NetworkImage(video![index]
                                                .video_caption_url
                                                .toString())
                                            : NetworkImage(""),
                                  ),
                                ),
                                padding: EdgeInsets.all(5),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(VideoWatchScreen(video![index]));
                                    videoController
                                        .setUrlVideo(video![index].video_url);
                                  },
                                )));
                      });
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('mental health test',
                              style: TextStyle(
                                  fontFamily: 'OdorMeanChey',
                                  fontWeight: FontWeight.bold)),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'See All',
                                style: TextStyle(
                                    fontFamily: 'OdorMeanChey',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(221, 56, 56, 1)),
                              ))
                        ]),
                  ),
                ],
              )),
          SizedBox(
            height: 150.0,
            child: StreamBuilder<List<Test>>(
              stream: testController.getAllTest(),
              builder: (context, snapshot) {
                List<Test>? test = snapshot.data;
                if (snapshot.hasData) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: test!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: test![index].test_cover_url != null
                                        ? NetworkImage(test![index]
                                            .test_cover_url
                                            .toString())
                                        : NetworkImage(""),
                                  ),
                                ),
                                padding: EdgeInsets.all(5),
                                child: GestureDetector(
                                    onTap: () =>
                                        Get.to(TestScreen(test![index])))));
                      });
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('books about mental health',
                              style: TextStyle(
                                  fontFamily: 'OdorMeanChey',
                                  fontWeight: FontWeight.bold)),
                          TextButton(
                              onPressed: () {},
                              child: Text('See All',
                                  style: TextStyle(
                                      fontFamily: 'OdorMeanChey',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(221, 56, 56, 1))))
                        ]),
                  ),
                ],
              )),
          SizedBox(
            height: 100.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [],
            ),
          ),
          SizedBox(height: 10)
        ]),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: BottomNavigationBar(
                  backgroundColor: Color.fromRGBO(20, 48, 199, 0.09),
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: GestureDetector(
                          child: SvgPicture.asset('assets/svg/phone-call.svg'),
                          onTap: () => Get.to(CrisisSupportScreen())),
                      label: 'Crisis Support',
                    ),
                    BottomNavigationBarItem(
                      icon: GestureDetector(
                          child: SvgPicture.asset('assets/svg/notes.svg'),
                          onTap: () => Get.to(DiagnoseScreen())),
                      label: 'Jurnalism',
                    ),
                    BottomNavigationBarItem(
                      icon: GestureDetector(
                          child:
                              SvgPicture.asset('assets/svg/calendar-month.svg'),
                          onTap: () => ()),
                      label: 'Appointment Scheduling',
                    ),
                    BottomNavigationBarItem(
                      icon: GestureDetector(
                          child: SvgPicture.asset(
                              'assets/svg/adjustments-horizontal.svg'),
                          onTap: () => Get.to(SettingScreen())),
                      label: 'Settings',
                    ),
                  ],
                ))));
  }
}
