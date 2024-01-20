
import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
 Video({
   this.videoCaptionUrl = "",
   this.videoTitle = "",
   this.videoId = "",
   this.videoUrl = "",
   this.videoDescription = ""
  });

   String? videoCaptionUrl;
   String? videoTitle;
   String? videoId;
   String videoUrl; 
   String? videoDescription;


  factory Video.fromSnapshot(DocumentSnapshot<Map<String,dynamic>>  document) {
    final data = document.data()!;
    return Video(
      videoId: document.id,
      videoCaptionUrl: data['video_caption_url'],
      videoTitle: data['video_title'],
      videoUrl: data['video_url'],
      videoDescription: data['video_description'],
    );
  }
}