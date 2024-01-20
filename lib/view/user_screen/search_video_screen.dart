import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/video_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/video.dart';

class SearchVideoScreen extends StatelessWidget {
  const SearchVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoController>(builder: (controller) {
      return WillPopScope(
          onWillPop: () async {
            controller.clearSearch();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('See All Video',
                  style: TextStyle(
                      fontFamily: 'OdorMeanChey',
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(221, 56, 56, 1))),
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(255, 220, 220, 1),
            ),
            backgroundColor: const Color.fromRGBO(255, 253, 208, 1),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      controller.setSearch(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      hintText: 'Search for video',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<Video>>(
                    stream: controller.searchVideo(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No Video found.'),
                        );
                      }

                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          List<Video>? videos = snapshot.data;
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () => controller.setVideo(videos[index]),
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      videos![index]
                                          .videoCaptionUrl
                                          .toString(),
                                    ),
                                    onError: (exception, stackTrace) {
                                      const Center(
                                        child: Text("Image Error"),
                                      );
                                    },
                                  ),
                                ),
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    },
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
