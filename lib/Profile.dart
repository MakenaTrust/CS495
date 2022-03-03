import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Users");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // FutureBuilder(
                //   future: Provider.of(context).auth.getCurrentID(),
                // ),
                Text(
                  'Event Holder Profile',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: Text('Create Event'),
                      onPressed: () {
                        Navigator.pushNamed(context, 'eventCreation_screen');
                      },
                    ),
              ]),
        ));
  }
}


      // var collection = FirebaseFirestore.instance
      //           .collection('Users').get().snapshots()
      // DocumentSnapshot data = snapshot.data!.docs[index];
      // Text(data["firstName"])
      // final user1 = _auth.currentUser;
      //                 final userid = user1?.uid;