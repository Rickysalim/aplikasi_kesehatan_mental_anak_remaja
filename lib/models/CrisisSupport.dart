
import 'package:cloud_firestore/cloud_firestore.dart';

class CrisisSupport {
  CrisisSupport({
   this.crisis_support_id = "",
   this.hospital_address = "",
   this.hospital_contact = "",
   this.hospital_name = "",
  }) {}

  String? crisis_support_id;
  String? hospital_address;
  String? hospital_contact;
  String? hospital_name;


  factory CrisisSupport.fromSnapshot(DocumentSnapshot<Map<String,dynamic>>  document) {
    final data = document.data()!;
    return CrisisSupport(
      crisis_support_id: document.id,
      hospital_address: data['hospital_address'],
      hospital_contact: data['hospital_contact'],
      hospital_name: data['hospital_name'],
    );
  }
}