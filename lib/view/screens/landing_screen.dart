import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/audio_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/timer_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/video_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/guards/user_guards_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Music.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Video.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/breathing_exercise_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/crisis_support_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/diagnose_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/music_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/setting_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/video_watch_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingScreen extends StatelessWidget {
  static const String id = "landing_screen";

  UserGuardsController userGuardsController = Get.put(UserGuardsController());
  VideoController videoController = Get.put(VideoController());
  MusicController musicController = Get.put(MusicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromRGBO(255, 253, 208, 1),
                  Color.fromRGBO(255, 255, 255, 1),
                ])),
            child: ListView(children: <Widget>[
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hi',
                                  style: TextStyle(
                                      fontFamily: 'MochiyPopOne',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color.fromRGBO(21, 0, 67, 1))),
                              Text(
                                  '${userGuardsController.user.currentUser!.displayName ?? "Unknown"}',
                                  style: TextStyle(
                                      fontFamily: 'MochiyPopOne',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color.fromRGBO(21, 0, 67, 1))),
                              Text("Let's manage your mental ",
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
                              Text('Video Learning',
                                  style: TextStyle(
                                      fontFamily: 'OdorMeanChey',
                                      fontWeight: FontWeight.bold)),
                            ]),
                      ),
                    ],
                  )),
              SizedBox(
                height: 200.0,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: StreamBuilder<List<Video>>(
                    stream: videoController.getAllVideo(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Video>? videos = snapshot.data;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: videos!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(VideoWatchScreen(videos[index]));
                                  videoController
                                      .setUrlVideo(videos[index].video_url);
                                },
                                child: Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        videos[index]
                                            .video_caption_url
                                            .toString(),
                                      ),
                                      onError: (exception, stackTrace) {
                                        // Tampilkan teks jika gambar gagal dimuat
                                        Container(
                                          child: Center(
                                            child: Text("Image Error"),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          videos[index].video_title.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
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
                              Text('Relaxing Music',
                                  style: TextStyle(
                                      fontFamily: 'OdorMeanChey',
                                      fontWeight: FontWeight.bold)),
                            ]),
                      ),
                    ],
                  )),
              SizedBox(
                  height: 200.0,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: StreamBuilder<List<Music>>(
                      stream: musicController.getAllMusic(),
                      builder: (context, snapshot) {
                        List<Music>? music = snapshot.data;
                        if (snapshot.hasData) {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: music!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                        width: 150,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(music[index]
                                                .music_cover
                                                .toString()),
                                            onError: (exception, stackTrace) {
                                              Center(
                                                child: Image.asset(
                                                    "assets/images/default-cover-music.jpg"),
                                              );
                                            },
                                          ),
                                        ),
                                        padding: EdgeInsets.all(5),
                                        child: GestureDetector(
                                          onTap: () {
                                            musicController.setUrlAudio(
                                                music[index]
                                                    .music_url
                                                    .toString());
                                            Get.to(MusicScreen(music[index]));
                                          },
                                          child: Text(music[index]
                                              .music_name
                                              .toString()),
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
                  )),
              GestureDetector(
                onTap: () => Get.to(DiagnoseScreen()),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/gif/heart.gif'),
                          )),
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Text('Diagnose',
                          style: TextStyle(
                              fontFamily: 'OdorMeanChey',
                              fontWeight: FontWeight.bold))),
                ),
              ),
              GestureDetector(
                  onTap: () => Get.to(BreatheExcerciseScreen()),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 250,
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                AssetImage('assets/gif/breathing_exercise.gif'),
                          )),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Text('Breathing Exercise',
                          style: TextStyle(
                              fontFamily: 'OdorMeanChey',
                              fontWeight: FontWeight.bold)),
                    ),
                  )),
              GestureDetector(
                onTap: () => Get.to(SettingScreen()),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/gif/customer-care.gif'),
                          )),
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Text('Help',
                          style: TextStyle(
                              fontFamily: 'OdorMeanChey',
                              fontWeight: FontWeight.bold))),
                ),
              ),
              SizedBox(height: 10)
            ])));
  }
}
