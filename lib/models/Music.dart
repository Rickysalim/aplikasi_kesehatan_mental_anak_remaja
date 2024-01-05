import 'package:cloud_firestore/cloud_firestore.dart';

class Music {
  Music(
      {this.music_id = "",
      this.music_name = "",
      this.music_url = "",
      this.music_cover = ""});

  String? music_id;
  String? music_name;
  String? music_url;
  String? music_cover;

  factory Music.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Music(
        music_id: document.id,
        music_name: data["music_name"],
        music_url: data["music_url"],
        music_cover: data["music_cover"]);
  }
}
