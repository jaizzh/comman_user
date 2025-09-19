import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  //get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get user stream
  Stream<List<Map<String, dynamic>>> getUsersStreeam() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //go through each indivdual user
        final user = doc.data();

        //retrun user
        return user;
      }).toList();
    });
  }
}
