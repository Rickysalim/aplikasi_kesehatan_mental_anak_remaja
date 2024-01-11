import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/video_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/user_screen/video_watch_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/Video.dart';

class SearchVideoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoController>(builder: (controller) {
      return WillPopScope(
          onWillPop: () async {
            controller.onClose();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title:
                  Text('Sell All Video', style: TextStyle(color: Colors.black)),
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Color.fromRGBO(255, 220, 220, 1),
            ),
            backgroundColor: Color.fromRGBO(255, 253, 208, 1),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      controller.setSearch(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Enter search term',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<Video>>(
                    stream: controller.searchVideo(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text('No Video found.'),
                        );
                      }

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          List<Video>? videos = snapshot.data;
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(VideoWatchScreen(videos[index]));
                                controller.setUrlVideo(videos[index].video_url);
                              },
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      videos![index]
                                          .video_caption_url
                                          .toString(),
                                    ),
                                    onError: (exception, stackTrace) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    },
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
