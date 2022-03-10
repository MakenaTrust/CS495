import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserQuery {
  getUser() async {
    final _auth = FirebaseAuth.instance;
    final user1 = _auth.currentUser;
    final userid = user1?.uid;

    print(userid);
    return userid.toString();
  }

  String fname = " ";
  String lname = " ";
  String uName = " ";
  bool coordinator = false;

  Future<String> fetchUserFirstName() async {
    // String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((user) {
      // setState(() {
      fname = user.data()!['firstName'];
      // lname = user.data()!['lastName'];
      // uName = user.data()!['username'];
      // coordinator = user.data()!['holder'];
    });
    return fname;
  }

  Future<String> fetchUserLastName() async {
    // String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((user) {
      // setState(() {
      lname = user.data()!['lastName'];
      // lname = user.data()!['lastName'];
      // uName = user.data()!['username'];
      // coordinator = user.data()!['holder'];
    });
    return lname;
  }

  Future<String> fetchUserUserName() async {
    // String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((user) {
      // setState(() {
      uName = user.data()!['username'];
      // coordinator = user.data()!['holder'];
    });
    return uName;
  }
}
