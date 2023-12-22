import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/video_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoWatchScreen extends StatefulWidget {
  static const String id = "detail_book_screen";
  VideoWatchScreen(this.video);

  // final Book? book;
  final Video? video;

  @override
  _VideoWatchScreenState createState() => _VideoWatchScreenState();
}

class _VideoWatchScreenState extends State<VideoWatchScreen> {
  final videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoController>(
      init: videoController,
      builder: (controller) {
      return WillPopScope(
        onWillPop: () async {
            if(controller.videoPlayerController != null) {
                 controller.onClose();
                 return true;
            }
            return false;
        },
        child:Scaffold(
          body: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(77, 67, 187, 1),
        ),
        child: widget.video != null
            ? ListView(children: [
                Container(
                    color: const Color.fromRGBO(77, 67, 187, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            iconSize: 40,
                            onPressed: () {
                              Get.back();
                              controller.onClose();
                            }),
                        Text('Video',
                            style: TextStyle(
                                fontFamily: 'MochiyPopOne',
                                fontSize: 16,
                                color: Colors.white)),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.star, color: Colors.white),
                          iconSize: 40,
                        ),
                        IconButton(
                            onPressed: () => Get.to(""),
                            icon: Icon(Icons.share, color: Colors.white),
                            iconSize: 40)
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(77, 67, 187, 1)),
                  child: FutureBuilder(
                      future: controller.initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return AspectRatio(
                            aspectRatio: controller
                                .videoPlayerController.value.aspectRatio,
                            child: VideoPlayer(
                                controller.videoPlayerController),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                Container(
                    child: Column(children: [
                  Slider(
                      value: controller.position.value.inSeconds.toDouble(),
                      min: 0.0,
                      max: controller.duration.value.inSeconds.toDouble(),
                      onChanged: (double newValue) {
                        controller.slider(newValue);
                      }),
                  Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                        Text(controller.formatTimeVideo(
                            controller.position.value.inSeconds)),
                        Text(controller.formatTimeVideo(
                            (controller.duration.value -
                                    controller.position.value)
                                .inSeconds))
                      ]))
                ])),
                // Row(
                //   children: <Widget>[
                //     Expanded(
                //       flex: 3,
                //       child: Container(
                //         color: Colors.green,
                //       ),
                //     ),
                //     Expanded(
                //       flex: 7,
                //       child: Container(
                //         color: Colors.yellow,

                //       ),
                //     ),
                //   ],
                // ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    // color: const Color.fromRGBO(255, 255, 255, 1)
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  onPressed: controller.onClickEvent,
                                  child: controller.isVideoPlaying.value ? Icon(Icons.pause) : Icon(Icons.play_arrow))
                            ]),
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(widget.video!.video_title ?? 'NA',
                                textAlign: TextAlign.left)),
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(widget.video!.video_description ?? 'NA',
                                textAlign: TextAlign.left)),
                      ]),
                ),
              ])
            : Align(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('404 Not Found',
                        style: TextStyle(
                            fontFamily: 'MochiyPopOne', fontSize: 50))),
                alignment: Alignment.center),
      )));
    });
  }
}
