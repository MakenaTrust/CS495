import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/bandedBoot_navigation/registration_navigation/signup_screen.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ImageFromGalleryEx extends StatefulWidget {
  final type;
  ImageFromGalleryEx(this.type);

  @override
  ImageFromGalleryExState createState() => ImageFromGalleryExState(this.type);
}

class ImageFromGalleryExState extends State<ImageFromGalleryEx> {
  var _image;
  var imagePicker;
  var type;
  var unique;
  String images =
      'https://firebasestorage.googleapis.com/v0/b/wrist-bands.appspot.com/o/Users%2Fwww.holdenadvisors.com:wp-content:uploads:2017:04:blank-profile-picture-973460_960_720.png?alt=media&token=f3bfac51-9ac1-4c80-9016-2458c30c5be5';
  bool picked = false;
  bool loading = false;

  ImageFromGalleryExState(this.type);

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            type == ImageSourceType.camera
                ? "Image from Camera"
                : "Image from Gallery",
            style: TextStyle(color: Color(0xFF6634B0))),
        leading: const BackButton(
          color: Color(0xFF6634B0),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 52,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                var source = type == ImageSourceType.camera
                    ? ImageSource.camera
                    : ImageSource.gallery;
                XFile image = await imagePicker.pickImage(
                    source: source,
                    imageQuality: 50,
                    preferredCameraDevice: CameraDevice.front);
                setState(() async {
                  _image = File(image.path);
                  uploadFile();
                });
              },
              // child: FutureBuilder<String>(
              //     future: getPic(context, unique, picked),
              //     builder:
              //         (BuildContext context, AsyncSnapshot<String> snapshot) {
              //       if (picked = false) {
              //         return Container(
              //           decoration: BoxDecoration(color: Color(0xFF6634B0)),
              //           width: 200,
              //           height: 200,
              //           child: Icon(
              //             Icons.camera_alt,
              //             color: Colors.white,
              //           ),
              //         );
              //       } else if (snapshot.connectionState ==
              //           ConnectionState.done) {
              //         return new CircleAvatar(
              //             backgroundColor: Colors.white,
              //             // backgroundImage:
              //             //     AssetImage('assets/images/profileTemp.png'),
              //             child: ClipOval(
              //                 child: Image.network(snapshot.data.toString(),
              //                     width: 150, height: 150, fit: BoxFit.cover)),
              //             radius: 100.0);
              //       }
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return new CircleAvatar(
              //           child: LoadingAnimationWidget.hexagonDots(
              //               color: Color(0xFF6634B0), size: 100),
              //           //     child: ClipOval(
              //           //         child: Image.network(
              //           //             'https://www.holdenadvisors.com/wp-content/uploads/2017/04/blank-profile-picture-973460_960_720.png',
              //           //             width: 150,
              //           //             height: 150,
              //           //             fit: BoxFit.cover)),
              //           // radius: 100.0
              //         );
              //       }
              //       return CircularProgressIndicator();
              //     }
              child: ClipOval(
                  // width: 200,
                  // height: 200,
                  // decoration: BoxDecoration(color: Color(0xFF6634B0)),
                  child: (picked == false)
                      ? Container(
                          decoration: BoxDecoration(color: Color(0xFF6634B0)),
                          width: 200,
                          height: 200,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        )
                      : (_image != null)
                          ? Image.network(
                              images,
                              width: 200.0,
                              height: 200.0,
                              fit: BoxFit.cover,
                            )
                          : LoadingAnimationWidget.hexagonDots(
                              color: Color(0xFF6634B0), size: 100)),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF6634B0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: const Text(
                'Save',
              ),
              onPressed: () async {
                (loading == true)
                    ? loadingContainer()
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationScreen(
                                picID: unique, picked: true)));
                // _showPicker(context);
              }),
        ],
      ),
    );
  }

  Future uploadFile() async {
    picked = true;
    unique = Uuid().v1();
    if (_image == null) return;
    final destination = 'Users/$unique';

    try {
      final ref = await firebase_storage.FirebaseStorage.instance
          .ref('Users/')
          .child(unique.toString());
      await ref.putFile(_image!);
    } catch (e) {
      print('error occured');
    }
    images = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${unique.toString()}')
        .getDownloadURL();
    setState(() {
      loading = false;
    });
  }

  Future<void> loadingContainer() async {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        loading = false;
      });
    });
  }
}
