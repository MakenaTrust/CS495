// import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';

class UserQuery {
  getUser() async {
    final _auth = FirebaseAuth.instance;
    final user1 = _auth.currentUser;
    final userid = user1?.uid;

    // print(userid);
    return userid.toString();
  }

  String fname = " ";
  String email = " ";
  String password = " ";
  String lname = " ";
  String uName = " ";
  String fileName = " ";
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

  Future<String> fetchUserName() async {
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

  Future<bool> fetchUserHolder() async {
    // String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((user) {
      // setState(() {
      coordinator = user.data()!['holder'];
      // coordinator = user.data()!['holder'];
    });
    return coordinator;
  }

  Future<String> fetchUserEmail() async {
    // String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((user) {
      // setState(() {
      email = user.data()!['email'];
      // coordinator = user.data()!['holder'];
    });
    return email;
  }

  Future<String> fetchUserPassword() async {
    // String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((user) {
      // setState(() {
      password = user.data()!['email'];
      // coordinator = user.data()!['holder'];
    });
    return password;
  }

  Future<String> fetchUserPicture() async {
    // String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((user) {
      // setState(() {
      fileName = user.data()!['filename'];
      // coordinator = user.data()!['holder'];
    });
    return fileName;
  }
  //   Future<String> fetchUserPicture() async {
  //   // String uid = FirebaseAuth.instance.currentUser!.uid;
  //   await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((user) {
  //     // setState(() {
  //     password = user.data()!['picture'];
  //   });
  //   return password;
  // }

  Future<String> updateUserName(String newUserName) async {
    // String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"username": newUserName});
    String searchUser = newUserName.toLowerCase();
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"searchUser": searchUser});
    // throw Exception("Couldn't update username");
    //     .then((user) {
    //   // setState(() {
    //   coordinator = user.data()!['holder'];
    //   // coordinator = user.data()!['holder'];
    // });
    return newUserName;
  }

  Future<String> updateFirstName(String newFirstName) async {
    // String uid = FirebaseAuth.instance.currentUser!.uid;
    if (newFirstName != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"firstName": newFirstName});
      // throw Exception("Couldn't update username");
      //     .then((user) {
      //   // setState(() {
      //   coordinator = user.data()!['holder'];
      //   // coordinator = user.data()!['holder'];
      // });
      return newFirstName;
    } else {
      return '';
    }
  }

  Future<String> updateLastName(String newLastName) async {
    // String uid = FirebaseAuth.instance.currentUser!.uid;
    if (newLastName != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"lastName": newLastName});
      // throw Exception("Couldn't update username");
      //     .then((user) {
      //   // setState(() {
      //   coordinator = user.data()!['holder'];
      //   // coordinator = user.data()!['holder'];
      // });
      return newLastName;
    } else {
      return '';
    }
  }

  Future<String> updatePassword(String newPassword) async {
    // String uid = FirebaseAuth.instance.currentUser!.uid;
    if (newPassword != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"password": newPassword});
      // throw Exception("Couldn't update username");
      //     .then((user) {
      //   // setState(() {
      //   coordinator = user.data()!['holder'];
      //   // coordinator = user.data()!['holder'];
      // });
      return newPassword;
    } else {
      return '';
    }
  }
}
