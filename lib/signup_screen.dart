import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController bDayController = TextEditingController();
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
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                controller: emailController,
                validator: validateEmail,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Enter your email',
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                obscureText: true,
                textAlign: TextAlign.center,
                controller: passwordController,
                validator: validatePassword,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Enter your password',
                ),
                // decoration: kTextFieldDecoration.copyWith(
                //     hintText: 'Enter your Password')
              ),
              Center(
                child: Text(errorMessage),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: userNameController,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Enter your username',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: fNameController,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Enter your first name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: lNameController,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Enter your last name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your last name';
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
                child: Text('Register'),
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                    errorMessage = '';
                  });
                  if (_formKey.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      final user = await _auth.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);
                      final user1 = _auth.currentUser;
                      final userid = user1?.uid;
                      var collection =
                          FirebaseFirestore.instance.collection("Users");
                      collection.doc(userid).set({
                        "email": emailController.text,
                        'password': passwordController.text,
                        "username": userNameController.text,
                        "firstName": fNameController.text,
                        "lastName": lNameController.text,
                        "holder": false
                      });
                      if (user != null) {
                        Navigator.pushNamed(context, 'login_screen');
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

  String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty) {
      return 'E-mail address is required.';
    }
    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';
    return null;
  }

  String? validatePassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty)
      return 'Password is required.';
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formPassword)) {
      return '''
      Password must be at least 8 characters,
      include an uppercase letter, number, and symbol.
      ''';
    }
    return null;
  }

  // void registerToFb() {
  //   firebaseAuth
  //       .createUserWithEmailAndPassword(
  //           email: emailController.text, password: passwordController.text)
  //       .then((result) {
  //     dbRef.child(result.user!.uid).set({
  //       "email": emailController.text,
  //       "password": passwordController.text,
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
    emailController.dispose();
    passwordController.dispose();
    fNameController.dispose();
    userNameController.dispose();
    lNameController.dispose();
    // ageController.dispose();
  }
}
