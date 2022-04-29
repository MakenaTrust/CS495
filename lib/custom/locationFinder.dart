import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class LocationQuery {
  Future<Position> _position = Geolocator.getCurrentPosition();
  Position? position;
  LocationPermission? permission;
  Position? loc;

  void _getCurrentLocation() async {
    position = await determinePosition();
    print("5." + position.toString());
    // setState(() {
    //   _position = position as Future<Position>;
    // });
  }

  Future<Position> determinePosition() async {
    print("in helper");
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }
    // print("3." + loc.toString());
    loc = (await Geolocator.getCurrentPosition());
    return Geolocator.getCurrentPosition();
  }
}
