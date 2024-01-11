import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/audio_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Music.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../get_x/controllers/music_admin_controller.dart';

class MusicAdminScreen extends StatelessWidget {
  MusicAdminController musicAdminController = Get.put(MusicAdminController());

  MusicController musicController = Get.put(MusicController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicAdminController>(
        init: musicAdminController,
        builder: (controller) {
          return WillPopScope(
              onWillPop: () async {
                controller.onClose();
                return true;
              },
              child: Scaffold(
                  appBar: AppBar(
                    leading: Builder(builder: (BuildContext context) {
                      return IconButton(
                          onPressed: () {
                            controller.onClose();
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back));
                    }),
                    title: Text('Music'),
                  ),
                  body: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Form(
                                key: controller.formKey.value,
                                child: Column(children: [
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    controller: controller.nameController.value,
                                    decoration: InputDecoration(
                                        labelText: 'Music Name'),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: controller.pickImage,
                                        child: Text('Pick Cover'),
                                      )),
                                  SizedBox(height: 10),
                                  controller.imageFile.value != null
                                      ? Text(controller.imageFile.value!.name)
                                      : Container(),
                                  SizedBox(height: 20),
                                  Container(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: controller.pickAudio,
                                        child: Text('Pick Music'),
                                      )),
                                  SizedBox(height: 10),
                                  controller.audioFile.value != null
                                      ? Text(controller.audioFile.value!.name)
                                      : Container(),
                                  SizedBox(height: 20),
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
                                                controller.audioFile.value !=
                                                    null) {
                                              if (controller
                                                  .setEditMusic.value) {
                                                await controller
                                                    .editAudio()
                                                    .then((value) {
                                                 controller.resetData();
                                                });
                                              } else {
                                                await controller
                                                    .uploadAudio()
                                                    .then((value) {
                                                    controller.resetData();
                                                });
                                              }
                                            } else {
                                              Get.snackbar("Kesalahan",
                                                  "Gambar dan Music harus di isi",
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                  backgroundColor: Colors.red,
                                                  colorText: Colors.white);
                                            }
                                          }
                                        },
                                        child: Text(
                                            controller.setEditMusic.value
                                                ? 'Update'
                                                : 'Add'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => controller.resetData(),
                                        child: Text('Reset Data'),
                                      ),
                                    ],
                                  ),
                                ])),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                onChanged: (value) {
                                  print(value);
                                  musicController.setSearch(value);
                                },
                                decoration: InputDecoration(
                                  labelText: 'Search',
                                  hintText: 'Enter search term',
                                  prefixIcon: Icon(Icons.search),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () {
                                  return StreamBuilder<List<Music>>(
                                      stream: musicController.searchMusic(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }

                                        if (snapshot.hasError) {
                                          return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'),
                                          );
                                        }

                                        if (!snapshot.hasData ||
                                            snapshot.data!.isEmpty) {
                                          return Center(
                                            child: Text('No Video found.'),
                                          );
                                        }

                                        return GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 8.0,
                                            mainAxisSpacing: 8.0,
                                          ),
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            List<Music>? musics = snapshot.data;
                                            return Padding(
                                              padding: EdgeInsets.all(10),
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.setIsEditVideo(
                                                      musics[index]);
                                                },
                                                child: Container(
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        musics![index]
                                                            .music_cover
                                                            .toString(),
                                                      ),
                                                      onError: (exception,
                                                          stackTrace) {
                                                        Container(
                                                          child: Center(
                                                            child: Text(
                                                                "Image Error"),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.all(5),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 150,
                                                        child: Text(
                                                          musics[index]
                                                              .music_name
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      });
                                },
                              ),
                            )
                          ]))));
        });
  }
}
