import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/auth_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/guards/user_guards_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/admin_screen/music_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/admin_screen/qa_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/admin_screen/rule_based_admin_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/admin_screen/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminLandingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {'name': 'Music', 'route': MusicAdminScreen()},
    {'name': 'Video', 'route': VideoAdminScreen()},
    {'name': 'Question Answer', 'route': QuestionAnswerAdminScreen()},
    {'name': 'Rule Based', 'route': RuleBasedDiagnoseAdminScreen()},
  ];

  final authController = Get.put(AuthController());

  final userGuardController = Get.put(UserGuardsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi ${userGuardController.user.currentUser!.displayName}'),
        actions: [
          IconButton(
              onPressed: () async => authController.logout(),
              icon: Icon(Icons.logout))
        ],
      ),
      body: GridView.builder(
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Get.to(items[index]['route']);
            },
            child: Card(
              elevation: 5,
              child: Center(
                child: Text(
                  items[index]['name'],
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
