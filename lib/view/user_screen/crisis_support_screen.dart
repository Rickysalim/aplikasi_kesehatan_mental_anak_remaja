import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/crisis_support_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/crisis_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CrisisSupportScreen extends StatelessWidget {
  static const String id = "crisis_support_screen";

  final crisisSupportController =
      Get.put(CrisisSupportController());

  CrisisSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<CrisisSupport>>(
            stream: crisisSupportController.getAllCrisisSupport(),
            builder: (context, snapshot) {
              List<CrisisSupport>? crisisSupportData = snapshot.data;
              if (snapshot.hasData) {
                return Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                        Color.fromRGBO(255, 253, 208, 1),
                        Color.fromRGBO(255, 255, 255, 1),
                      ])),
                  child: ListView.builder(
                    itemCount: crisisSupportData?.length,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 220, 220, 1),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                      'Nama Rumah Sakit: ${crisisSupportData![index].hospitalName.toString()}',
                                      style: const TextStyle(
                                          fontFamily: 'MochiyPopOne',
                                          fontSize: 5,
                                          color: Colors.black))),
                              Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                      'Phone Number: ${crisisSupportData[index].hospitalContact.toString()}',
                                      style: const TextStyle(
                                          fontFamily: 'MochiyPopOne',
                                          fontSize: 5,
                                          color: Colors.black))),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    'Alamat: ${crisisSupportData[index].hospitalAddress.toString()}',
                                    style: const TextStyle(
                                        fontFamily: 'MochiyPopOne',
                                        fontSize: 5,
                                        color: Colors.black)),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: IconButton(
                                      icon: SvgPicture.asset(
                                          'assets/svg/phone-call.svg'),
                                      onPressed: () async {
                                        await FlutterPhoneDirectCaller
                                            .callNumber(
                                                crisisSupportData[index]
                                                    .hospitalContact
                                                    .toString());
                                      }))
                            ],
                          ));
                    },
                  ),
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
            }));
  }
}
