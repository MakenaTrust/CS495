// ignore_for_file: unnecessary_new

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/custom/imageQuery.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

enum ImageSourceType { gallery, camera }

class RegistrationScreen extends StatefulWidget {
  String? picID;
  bool picked;

  RegistrationScreen({this.picID, required this.picked});
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
  String dbURL =
      'https://firebasestorage.googleapis.com/v0/b/wrist-bands.appspot.com/o/Users%2Fwww.holdenadvisors.com:wp-content:uploads:2017:04:blank-profile-picture-973460_960_720.png?alt=media&token=f3bfac51-9ac1-4c80-9016-2458c30c5be5';
  String imageUrl =
      'https://www.holdenadvisors.com/wp-content/uploads/2017/04/blank-profile-picture-973460_960_720.png';
  File? _photo;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  ImagePicker picker = ImagePicker();

  void getDB() async {
    firebase_storage.FirebaseStorage storages =
        firebase_storage.FirebaseStorage.instance;
    setState(() {
      this.storage = storages;
    });
  }

  @override
  void initState() {
    super.initState();

    getDB();
    //until this is completed user stays null we can use it to check whether it's loaded
  }

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
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: FutureBuilder<String>(
                      future: getPic(
                          context, widget.picID.toString(), widget.picked),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return new CircleAvatar(
                              backgroundColor: Colors.white,
                              // backgroundImage:
                              //     AssetImage('assets/images/profileTemp.png'),
                              child: ClipOval(
                                  child: Image.network(snapshot.data.toString(),
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover)),
                              radius: 100.0);
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return new CircleAvatar(
                            child: LoadingAnimationWidget.hexagonDots(
                                color: Color(0xFF6634B0), size: 100),
                            //     child: ClipOval(
                            //         child: Image.network(
                            //             'https://www.holdenadvisors.com/wp-content/uploads/2017/04/blank-profile-picture-973460_960_720.png',
                            //             width: 150,
                            //             height: 150,
                            //             fit: BoxFit.cover)),
                            // radius: 100.0
                          );
                        }
                        return CircularProgressIndicator();
                      }
                      // child: ClipRRect(
                      //         borderRadius: BorderRadius.circular(50),
                      //         child: Image.network(
                      //           getPic(widget.picID.toString()),
                      //           width: 100,
                      //           height: 100,
                      //           fit: BoxFit.fitHeight,
                      //         ))
                      // (imageUrl.isNotEmpty)
                      //     ? Image.network(imageUrl)
                      //     :
                      // height: 100,
                      // width: 10,
                      )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF6634B0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text(
                    'Submit a profile picture',
                  ),
                  onPressed: () {
                    _showPicker(context);
                  }),
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
              const SizedBox(
                height: 8.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF6634B0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: const Text('Register'),
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
                        "filename": dbURL,
                        "holder": false
                      });
                      if (user != null) {
                        print("not null");
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
    if (formPassword == null || formPassword.isEmpty) {
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
    return null;
  }

  void _handleGalButtonPress(BuildContext context, var type) {
    String file = 'profile';
    _photo = Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ImageFromGalleryEx(type, file))) as File?;
  }

  // void _handleCamButtonPress(BuildContext context, var type) {
  //   _photo = Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type)))
  //       as File?;
  // }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () {
                        _handleGalButtonPress(context, ImageSourceType.gallery);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _handleGalButtonPress(context, ImageSourceType.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<String> getPic(
      BuildContext context, String unique, bool picker) async {
    setState(() {
      // picker = true;
    });
    Image image;
    // String text =
    //     'https://www.holdenadvisors.com/wp-content/uploads/2017/04/blank-profile-picture-973460_960_720.png';
    // ;
    if (picker == false)
      unique =
          'www.holdenadvisors.com:wp-content:uploads:2017:04:blank-profile-picture-973460_960_720.png';
    // if (picker == false)
    // return 'https://www.holdenadvisors.com/wp-content/uploads/2017/04/blank-profile-picture-973460_960_720.png';
    // else
    //   debugPrint("in get pic");
    final images = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${unique.toString()}');
    String pic = await images.getDownloadURL();
    dbURL = pic;
    // filename = unique.toString() as TextEditingController;
    print(pic);
    return pic;
    // debugPrint(pic);
  }

  // Future uploadFile(var _image) async {
  //   if (_image == null) return;
  //   final userid = FirebaseAuth.instance.currentUser?.uid;
  //   print("UID");
  //   print(userid);
  //   final destination = 'Users/$userid';

  //   //   try {
  //   //     final ref = firebase_storage.FirebaseStorage.instance
  //   //         .ref(destination)
  //   //         .child(userid);
  //   //     await ref.putFile(_image!);
  //   //   } catch (e) {
  //   //     print('error occured');
  //   //   }
  //   // }
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
