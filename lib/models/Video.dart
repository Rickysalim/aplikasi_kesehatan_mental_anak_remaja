
import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
 Video({
   this.video_caption_url = "",
   this.video_title = "",
   this.video_id = "",
   this.video_url = "",
   this.video_description = ""
  }) {}

   String? video_caption_url;
   String? video_title;
   String? video_id;
   String video_url; 
   String? video_description;


  factory Video.fromSnapshot(DocumentSnapshot<Map<String,dynamic>>  document) {
    final data = document.data()!;
    return Video(
      video_id: document.id,
      video_caption_url: data['video_caption_url'],
      video_title: data['video_title'],
      video_url: data['video_url'],
      video_description: data['video_description'],
    );
  }
}