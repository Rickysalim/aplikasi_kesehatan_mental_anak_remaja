
import 'package:cloud_firestore/cloud_firestore.dart';

class CrisisSupport {
  CrisisSupport({
   this.crisisSupportId = "",
   this.hospitalAddress = "",
   this.hospitalContact = "",
   this.hospitalName = "",
  });

  String? crisisSupportId;
  String? hospitalAddress;
  String? hospitalContact;
  String? hospitalName;


  factory CrisisSupport.fromSnapshot(DocumentSnapshot<Map<String,dynamic>>  document) {
    final data = document.data()!;
    return CrisisSupport(
      crisisSupportId: document.id,
      hospitalAddress: data['hospital_address'],
      hospitalContact: data['hospital_contact'],
      hospitalName: data['hospital_name'],
    );
  }
}