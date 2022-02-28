import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'home_screen.dart';

class EventCreationScreen extends StatefulWidget {
  @override
  _EventCreationScreenState createState() => _EventCreationScreenState();
}

class _EventCreationScreenState extends State<EventCreationScreen> {
  final _auth = FirebaseAuth.instance;
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Users");
  String errorMessage = '';
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        // inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                textAlign: TextAlign.center,
                controller: eventNameController,
                //validator: validateEventName,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Event Name',
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: eventDateController,
                //validator: validateEventDate,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Event Date',
                ),
              ),
              Center(
                child: Text(errorMessage),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: eventLocationController,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Event Location',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Event Location';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: capacityController,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Event Capacity',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Event Capacity';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: typeController,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Type of Event',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Type of Event';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                child: Text('Register Event'),
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                    errorMessage = '';
                  });
                  if (_formKey.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: eventNameController.text,
                        password: eventDateController.text,
                      );
                      final user = await _auth.signInWithEmailAndPassword(
                          email: eventNameController.text,
                          password: eventDateController.text);
                      final user1 = _auth.currentUser;
                      final userid = user1?.uid;
                      var collection =
                          FirebaseFirestore.instance.collection("Users");
                      collection.doc(userid).set({
                        "email": eventNameController.text,
                        'password': eventDateController.text,
                        "username": eventLocationController.text,
                        "firstName": capacityController.text,
                        "lastName": 'NOT REAL!',
                        "holder": false
                      });
                      if (user != null) {
                        Navigator.pushNamed(
                            context, 'eventCreationSuccess_screen');
                      }
                      // errorMessage = '';
                    } on FirebaseAuthException catch (error) {
                      errorMessage = error.message!;
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
// }

  // String? validateEventName(String? formEmail) {
  //   if (formEmail == null || formEmail.isEmpty) {
  //     return 'Event Name is required.';
  //   };
  //   return null;
  // }

  // String? validateEventDate(String? formPassword) {
  //   if (formPassword == null || formPassword.isEmpty)
  //     return 'Password is required.';
  //   String pattern =
  //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*[!@#\$&*~-]).{8,}$';
  //   RegExp regex = RegExp(pattern);
  //   if (!regex.hasMatch(formPassword)) {
  //     return '''
  //     Password must be at least 8 characters,
  //     include an uppercase letter, number, and symbol.
  //     ''';
  //   }
  //   return null;
  // }

  // void registerToFb() {
  //   firebaseAuth
  //       .createUserWithEmailAndPassword(
  //           email: eventNameController.text, password: eventDateController.text)
  //       .then((result) {
  //     dbRef.child(result.user!.uid).set({
  //       "email": eventNameController.text,
  //       "password": eventDateController.text,
  //       // "age": ageController.text,
  //       // "name": nameController.text
  //     }).then((res) {
  //       showSpinner = false;
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => HomeScreen(
  //                   uid: result.user!.uid,
  //                   title: '',
  //                 )),
  //       );
  //     });
  //   }).catchError((err) {
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text("Error"),
  //             content: Text(err.message),
  //             actions: [
  //               TextButton(
  //                 child: Text("Ok"),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               )
  //             ],
  //           );
  //         });
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    // nameController.dispose();
    eventNameController.dispose();
    eventDateController.dispose();
    capacityController.dispose();
    eventLocationController.dispose();
    typeController.dispose();
    // ageController.dispose();
  }
}
