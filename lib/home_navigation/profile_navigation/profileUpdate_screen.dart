import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
import '/custom/userQuery.dart';
import '/custom/eventQuery.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  TextEditingController newUsernameController = TextEditingController();
  TextEditingController newFirstNameController = TextEditingController();
  TextEditingController newLastNameController = TextEditingController();
  TextEditingController newPasswordController1 = TextEditingController();
  TextEditingController newPasswordController2 = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Users");
  String errorMessage = '';
  bool showSpinner = false;
  String currentSelectedValue = 'Music';
  UserQuery x = UserQuery();
  String fname = " ";
  String lname = " ";
  String uName = " ";
  // static const String me = "me";
  bool changed = false;

  @override
  void initState() {
    super.initState();
    UserQuery x = UserQuery();
    EventQuery y = EventQuery();
    x.fetchUserFirstName().then((String result) {
      setState(() {
        fname = result;
      });
    });
    x.fetchUserLastName().then((String result) {
      setState(() {
        lname = result;
      });
    });
    x.fetchUserName().then((String result) {
      setState(() {
        uName = result.toString();
      });
    });

    // y.fetchEventName().then((QuerySnapshot result) {
    //   setState(() {
    //     eventName = result;
    //   });
    //   print(result.docs);
    // });
  }
  // username = x.fetchUserName().toString();
  // String fname = x.fetchUserFirstName().toString();
  // String lname = x.fetchUserLastName().toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/bandedLogo.png', scale: 15),
        leading: const BackButton(
          color: Color(0xFF6634B0),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        // inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text('Edit the information you wish to change',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                textAlign: TextAlign.center,
                controller: newUsernameController,
                //validator: validateEventName,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: '$uName',
                ),
              ),
              const Text("Change username"),
              TextFormField(
                textAlign: TextAlign.center,
                controller: newFirstNameController,
                //validator: validateEventName,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: '$fname',
                ),
              ),
              const Text("Change first name"),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: newLastNameController,
                //validator: validateEventName,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: '$lname',
                ),
              ),
              const Text("Change last name"),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: newPasswordController1,
                // validator: validatePassword,
                validator: (value) {
                  String p1 = newPasswordController1.toString();
                  // String p2 = newPasswordController2.toString();
                  // if (value == null) {
                  //   // print(value);
                  //   return 'Password is required.';
                  // }
                  //             String pattern =
                  //                 r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*[!@#\$&*~-]).{8,}$';
                  //             RegExp regex = RegExp(pattern);
                  //             if (!regex.hasMatch(value)) {
                  //               return '''
                  // Password must be at least 8 characters,
                  // include an uppercase letter, number, and symbol.
                  // ''';
                  //             }
                  return null;
                },
                obscureText: true,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  hintText: 'Enter new password',
                ),
              ),
              // Text("Change password"),
              TextFormField(
                textAlign: TextAlign.center,
                controller: newPasswordController2,
                obscureText: true,
                validator: (value) {
                  String p1 = newPasswordController1.text;
                  String p2 = newPasswordController2.text;
                  // if (value == null) {
                  //   print(value);
                  //   return 'Password is required.';
                  // }
                  if (value != p1) {
                    if (p1.isEmpty & p1.isNotEmpty) {
                      // print(value);
                      // print(p1);
                      return 'Re-enter password';
                    } else {
                      return 'Passwords must match.';
                    }
                  }
                  String pattern =
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*[!@#\$&*~-]).{8,}$';
                  RegExp regex = RegExp(pattern);
                  if (!regex.hasMatch(p2.toString()) && p2.isNotEmpty) {
                    return '''
                  Password must be at least 8 characters,
                  include an uppercase letter, number, and symbol.
                  ''';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  hintText: 'Re-enter new password',
                ),
              ),
              const Text("Change password"),
              const SizedBox(
                height: 8.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF6634B0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: const Text('Update Profile'),
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                    errorMessage = '';
                  });
                  if (_formKey.currentState!.validate()) {
                    if (newUsernameController.text.isNotEmpty) {
                      // print("new user : " + '$uName');
                      try {
                        x
                            .updateUserName(newUsernameController.text)
                            .then((String result) {
                          setState(() {
                            newFirstNameController.text = result;
                          });
                          changed = true;
                          // Navigator.pushNamed(
                          //     context, 'profileUpdateSuccess_screen');
                        });
                      } on FirebaseAuthException catch (error) {
                        errorMessage = error.message!;
                      }
                    }
                    if (newFirstNameController.text.isNotEmpty) {
                      // print("new user : " + '$uName');
                      try {
                        x
                            .updateFirstName(newFirstNameController.text)
                            .then((String result) {
                          setState(() {
                            newFirstNameController.text = result;
                          });
                          changed = true;
                          // Navigator.pushNamed(
                          //     context, 'profileUpdateSuccess_screen');
                        });
                      } on FirebaseAuthException catch (error) {
                        errorMessage = error.message!;
                      }
                    }
                    if (newLastNameController.text.isNotEmpty) {
                      // print("new user : " + '$uName');
                      try {
                        x
                            .updateLastName(newLastNameController.text)
                            .then((String result) {
                          setState(() {
                            newUsernameController.text = result;
                          });
                          changed = true;
                          // Navigator.pushNamed(
                          //     context, 'profileUpdateSuccess_screen');
                        });
                      } on FirebaseAuthException catch (error) {
                        errorMessage = error.message!;
                      }
                    }
                    if ((newPasswordController1.text.isNotEmpty &
                            newPasswordController2.text.isNotEmpty) &
                        (newPasswordController1.text ==
                            newPasswordController2.text)) {
                      // print("new pass : " + '$newPasswordController2');
                      try {
                        x
                            .updatePassword(newPasswordController2.text)
                            .then((String result) {
                          setState(() {
                            newPasswordController2.text = result;
                          });
                          changed = true;
                          // Navigator.pushNamed(
                          //     context, 'profileUpdateSuccess_screen');
                        });
                      } on FirebaseAuthException catch (error) {
                        errorMessage = error.message!;
                      }
                    }
                    if (changed = true) {
                      Navigator.pushNamed(
                          context, 'profileUpdateSuccess_screen');
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

  String? validatePassword(formPassword) {
    // print(formPassword);
    String p1 = newPasswordController1.toString();
    String p2 = newPasswordController2.toString();
    if (p1 == null || p2 == null) {
      return 'Password is required.';
    }
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*[!@#\$&*~-]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formPassword)) {
      return '''
      Password must be at least 8 characters,
      include an uppercase letter, number, and symbol.
      ''';
    }
    if (p1 != p2) {
      return 'Passwords must match.';
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    // nameController.dispose();
    newUsernameController.dispose();
    // ageController.dispose();
    newUsernameController.dispose();
    newFirstNameController.dispose();
    newLastNameController.dispose();
    newPasswordController1.dispose();
    newPasswordController2.dispose();
  }
}
