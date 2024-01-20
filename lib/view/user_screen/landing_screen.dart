import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/audio_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/video_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/guards/user_guards_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/music.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/video.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/user_screen/breathing_exercise_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/user_screen/diagnose_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/user_screen/search_music_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/user_screen/search_video_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/user_screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key});
  static const String id = "landing_screen";

  final userGuardsController = Get.put(UserGuardsController());
  final videoController = Get.put(VideoController());
  final musicController = Get.put(MusicController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromRGBO(255, 253, 208, 1),
                  Color.fromRGBO(255, 255, 255, 1),
                ])),
            child: ListView(children: <Widget>[
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
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
                              const Text('Hi',
                                  style: TextStyle(
                                      fontFamily: 'MochiyPopOne',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color.fromRGBO(21, 0, 67, 1))),
                              Text(
                                  userGuardsController.user.currentUser!.displayName ?? "Unknown",
                                  style: const TextStyle(
                                      fontFamily: 'MochiyPopOne',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color.fromRGBO(21, 0, 67, 1))),
                              const Text("Let's manage your mental ",
                                  style: TextStyle(
                                      fontFamily: 'MochiyPopOne',
                                      color: Color.fromRGBO(21, 0, 67, 1))),
                              const Text('with us!',
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
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Video Learning',
                                  style: TextStyle(
                                      fontFamily: 'OdorMeanChey',
                                      fontWeight: FontWeight.bold)),
                              TextButton(
                                  onPressed: () => Get.to(const SearchVideoScreen()),
                                  child: const Text(
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
                height: 200.0,
                child: Padding(
                  padding: const EdgeInsets.all(10),
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
                              padding: const EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () =>  videoController.setVideo(videos[index]),
                                child: Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        videos[index]
                                            .videoCaptionUrl
                                            .toString(),
                                      ),
                                      onError: (exception, stackTrace) {
                                        // Tampilkan teks jika gambar gagal dimuat
                                        const Center(
                                          child: Text("Image Error"),
                                        );
                                      },
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          videos[index].videoTitle.toString(),
                                          style: const TextStyle(
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
                        return const Center(
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
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Relaxing Music',
                                  style: TextStyle(
                                      fontFamily: 'OdorMeanChey',
                                      fontWeight: FontWeight.bold)),
                              TextButton(
                                  onPressed: () => Get.to(const SearchMusicScreen()),
                                  child: const Text(
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
                  height: 200.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
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
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                        width: 150,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(music[index]
                                                .musicCover
                                                .toString()),
                                            onError: (exception, stackTrace) {
                                              Center(
                                                child: Image.asset(
                                                    "assets/images/default-cover-music.jpg"),
                                              );
                                            },
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(5),
                                        child: GestureDetector(
                                          onTap: () {
                                            musicController.setAudio(music[index]);
                                          },
                                          child: Text(music[index]
                                              .musicName
                                              .toString()),
                                        )));
                              });
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else {
                          return const Center(
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
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/gif/heart.gif'),
                          )),
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: const Text('Diagnose',
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
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                AssetImage('assets/gif/breathing_exercise.gif'),
                          )),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: const Text('Breathing Exercise',
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
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/gif/customer-care.gif'),
                          )),
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: const Text('Settings',
                          style: TextStyle(
                              fontFamily: 'OdorMeanChey',
                              fontWeight: FontWeight.bold))),
                ),
              ),
              const SizedBox(height: 10)
            ])));
  }
}
