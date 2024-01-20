import 'package:cloud_firestore/cloud_firestore.dart';

class Music {
  Music(
      {this.musicId = "",
      this.musicName = "",
      this.musicUrl = "",
      this.musicCover = ""});

  String? musicId;
  String? musicName;
  String? musicUrl;
  String? musicCover;

  factory Music.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Music(
        musicId: document.id,
        musicName: data["music_name"],
        musicUrl: data["music_url"],
        musicCover: data["music_cover"]);
  }
}
