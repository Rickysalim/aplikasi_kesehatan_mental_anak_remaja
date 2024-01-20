import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/video_admin_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/video_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageVideoAdminScreen extends StatelessWidget {
  ManageVideoAdminScreen({super.key});
  final  videoAdminController = Get.put(VideoAdminController());
  final videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoAdminController>(
        init: videoAdminController,
        builder: (controller) {
          return WillPopScope(
              onWillPop: () async {
                controller.clearAllData();
                videoController.clearSearch();
                return true;
              },
              child: Scaffold(
                  appBar: AppBar(
                    title: const Text('Video'),
                    leading: Builder(builder: (BuildContext context) {
                      return IconButton(
                          onPressed: () {
                            controller.onClose();
                            Get.back();
                          },
                          icon: const Icon(Icons.arrow_back));
                    }),
                  ),
                  body: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Form(
                                key: controller.formKey.value,
                                child: Column(children: <Widget>[
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    controller:
                                        controller.titleController.value,
                                    decoration: const InputDecoration(
                                        labelText: 'Video Title'),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    controller:
                                        controller.descriptionController.value,
                                    decoration: const InputDecoration(
                                        labelText: 'Video Description'),
                                    maxLines: 3,
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: controller.pickImage,
                                        child: const Text('Pick Image'),
                                      )),
                                  const SizedBox(height: 10),
                                  controller.imageFile.value != null
                                      ? Text(controller.imageFile.value!.name)
                                      : Container(),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: controller.pickVideo,
                                        child: const Text('Pick Video'),
                                      )),
                                  const SizedBox(height: 10),
                                  controller.videoFile.value != null
                                      ? Text(controller.videoFile.value!.name)
                                      : Container(),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (controller
                                              .formKey.value.currentState!
                                              .validate()) {
                                            if (controller.imageFile.value !=
                                                    null ||
                                                controller.videoFile.value !=
                                                    null) {
                                              if (controller
                                                  .setEditVideo.value) {
                                                await controller
                                                    .editVideo()
                                                    .then((value) {
                                                 controller.resetData();
                                                });
                                              } else {
                                                await controller
                                                    .uploadVideo()
                                                    .then((value) {
                                                   controller.resetData();
                                                });
                                              }
                                            } else {
                                              Get.snackbar("Empty Field",
                                                  "Image And Video must be fill");
                                            }
                                          }
                                        },
                                        child: Text(
                                            controller.setEditVideo.value
                                                ? 'Update'
                                                : 'Add'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => controller.resetData(),
                                        child: const Text('Reset Data'),
                                      ),
                                    ],
                                  ),
                                ])),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                onChanged: (value) {
                                  videoController.setSearch(value);
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Search',
                                  hintText: 'Enter search term',
                                  prefixIcon: Icon(Icons.search),
                                ),
                              ),
                            ),
                            Expanded(
                              child: StreamBuilder<List<Video>>(
                                stream: videoController.searchVideo(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  }

                                  if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return const Center(
                                      child: Text('No Video found.'),
                                    );
                                  }

                                  return GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                          onTap: () {
                                            controller
                                                .setIsEditVideo(videos[index]);
                                          },
                                          child: Container(
                                            width: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  videos![index]
                                                      .videoCaptionUrl
                                                      .toString(),
                                                ),
                                                onError:
                                                    (exception, stackTrace) {
                                                  const Center(
                                                    child:
                                                        Text("Image Error"),
                                                  );
                                                },
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(5),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    videos[index]
                                                        .videoTitle
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                          ]))));
        });
  }
}
