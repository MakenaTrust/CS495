import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class EventQuery {
  getUser() async {
    final _auth = FirebaseAuth.instance;
    final user1 = _auth.currentUser;
    final userid = user1?.uid;

    print(userid);
    return userid.toString();
  }
  // String lname = " ";
  // String uName = " ";
  // bool coordinator = false;

  Future<QuerySnapshot> fetchEventName() async {
    final QuerySnapshot result = FirebaseFirestore.instance
        .collection('Events')
        .snapshots() as QuerySnapshot<Object?>;
    // final List<QueryDocumentSnapshot> eventName = result.docs.toList();
    // eventName.forEach((data) => print(data));
    // String uid = FirebaseAuth.instance.currentUser!.uid;
    // await FirebaseFirestore.instance
    //     .collection('Artists')
    //     .doc()
    //     .get()
    //     .then((user) {
    //   // setState(() {
    //   eventName = user.data()!['EventName'];
    //   // lname = user.data()!['lastName'];
    //   // uName = user.data()!['username'];
    //   // coordinator = user.data()!['holder'];
    // });
    // print(eventName);
    return result;
  }
}
