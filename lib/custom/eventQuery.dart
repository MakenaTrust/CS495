import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
// import 'package:firebase_database/firebase_database.dart';

class EventQuery {
  String date = " ";
  String name = " ";
  String capacity = " ";
  String endTime = " ";
  String location = " ";
  String startTime = " ";
  String type = " ";
  String picture = " ";

  //Fetchers

  Future<String> fetchEventDate(String eventID) async {
    await FirebaseFirestore.instance
        .collection('Events')
        .doc(eventID)
        .get()
        .then((event) {
      date = event.data()!['Date'].toString();
    });
    return date;
  }

  Future<String> fetchEventName(String eventID) async {
    await FirebaseFirestore.instance
        .collection('Events')
        .doc(eventID)
        .get()
        .then((event) {
      name = event.data()!['EventName'].toString();
    });
    return name;
  }

  Future<String> fetchEventCapacity(String eventID) async {
    await FirebaseFirestore.instance
        .collection('Events')
        .doc(eventID)
        .get()
        .then((event) {
      capacity = event.data()!['capacity'].toString();
    });
    return capacity;
  }

  Future<String> fetchEventEndTime(String eventID) async {
    await FirebaseFirestore.instance
        .collection('Events')
        .doc(eventID)
        .get()
        .then((event) {
      endTime = event.data()!['eventEndTime'].toString();
    });
    return endTime;
  }

  Future<String> fetchEventLocation(String eventID) async {
    await FirebaseFirestore.instance
        .collection('Events')
        .doc(eventID)
        .get()
        .then((event) {
      location = event.data()!['eventLocation'].toString();
    });
    return location;
  }

  Future<String> fetchEventStartTime(String eventID) async {
    await FirebaseFirestore.instance
        .collection('Events')
        .doc(eventID)
        .get()
        .then((event) {
      startTime = event.data()!['eventStartTime'].toString();
    });
    return startTime;
  }

  Future<String> fetchEventType(String eventID) async {
    await FirebaseFirestore.instance
        .collection('Events')
        .doc(eventID)
        .get()
        .then((event) {
      type = event.data()!['eventType'].toString();
    });
    return type;
  }

  Future<String> fetchEventPicture(String eventID) async {
    await FirebaseFirestore.instance
        .collection('Events')
        .doc(eventID)
        .get()
        .then((event) {
      picture = event.data()!['ticketFile'].toString();
    });
    return picture;
  }
}
