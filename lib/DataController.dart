import 'package:cloud_firestore/cloud_firestore.dart';

class DataController {
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }

  queryEventData(String queryString) {
    return FirebaseFirestore.instance
        .collection('Events')
        .where('EventName',
            isEqualTo: queryString.substring(0, 1).toUpperCase())
        .get();
  }
}
