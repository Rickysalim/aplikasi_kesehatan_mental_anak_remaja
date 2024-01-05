import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/crisis_support_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/CrisisSupport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CrisisSupportScreen extends StatelessWidget {
  static const String id = "crisis_support_screen";

  CrisisSupportController crisisSupportController =
      Get.put(CrisisSupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<CrisisSupport>>(
            stream: crisisSupportController.getAllCrisisSupport(),
            builder: (context, snapshot) {
              List<CrisisSupport>? crisisSupportData = snapshot.data;
              if (snapshot.hasData) {
                return Container(
                  decoration: BoxDecoration(
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
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 220, 220, 1),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                      'Nama Rumah Sakit: ${crisisSupportData![index].hospital_name.toString()}',
                                      style: TextStyle(
                                          fontFamily: 'MochiyPopOne',
                                          fontSize: 5,
                                          color: Colors.black))),
                              Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                      'Phone Number: ${crisisSupportData![index].hospital_contact.toString()}',
                                      style: TextStyle(
                                          fontFamily: 'MochiyPopOne',
                                          fontSize: 5,
                                          color: Colors.black))),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    'Alamat: ${crisisSupportData[index].hospital_address.toString()}',
                                    style: TextStyle(
                                        fontFamily: 'MochiyPopOne',
                                        fontSize: 5,
                                        color: Colors.black)),
                              ),
                              Container(
                                  child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: IconButton(
                                          icon: SvgPicture.asset(
                                              'assets/svg/phone-call.svg'),
                                          onPressed: () async {
                                            await FlutterPhoneDirectCaller
                                                .callNumber(
                                                    crisisSupportData![index]
                                                        .hospital_contact
                                                        .toString());
                                          })))
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
