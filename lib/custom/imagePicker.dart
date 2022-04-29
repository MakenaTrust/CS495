import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/bandedBoot_navigation/registration_navigation/signup_screen.dart';
import 'package:flutter_application_1/home_navigation/profile_navigation/eventCreation_screen.dart';

// import 'package:firebase_storage/firebase_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

enum ImageSourceType { gallery, camera }

class ImageFromGalleryEx extends StatefulWidget {
  final type;
  final file;
  ImageFromGalleryEx(this.type, this.file);

  @override
  ImageFromGalleryExState createState() =>
      ImageFromGalleryExState(this.type, this.file);
}

class ImageFromGalleryExState extends State<ImageFromGalleryEx> {
  var _image;
  var imagePicker;
  var type;
  var file;
  var unique;
  String images =
      'https://firebasestorage.googleapis.com/v0/b/wrist-bands.appspot.com/o/Users%2Floading.jpeg?alt=media&token=f3bfac51-9ac1-4c80-9016-2458c30c5be5';
  bool picked = false;
  bool loading = false;

  ImageFromGalleryExState(this.type, this.file);

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
                setState(() {
                  _image = File(image.path);
                  uploadFile();
                });
              },
              child: (file == 'profile')
                  ? ClipOval(
                      child: (picked == false)
                          ? Container(
                              decoration:
                                  BoxDecoration(color: Color(0xFF6634B0)),
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
                                  color: Color(0xFF6634B0), size: 100))
                  : Card(
                      child: (picked == false)
                          ? Container(
                              decoration:
                                  BoxDecoration(color: Color(0xFF6634B0)),
                              width: 320,
                              height: 200,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            )
                          : (_image != null)
                              ? Image.network(
                                  images,
                                  width: 320.0,
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
                    : (file == 'profile')
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationScreen(
                                    picID: unique, picked: true)))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EventCreationScreen(
                                    picID: unique, picked: true)));
                // _showPicker(context);
              }),
        ],
      ),
    );
  }

  Future uploadFile() async {
    String prefix = 'Users/';
    picked = true;
    if (file == "band") prefix = 'Events/';
    unique = Uuid().v1();
    if (_image == null) return;
    final destination = '$prefix$unique';

    print("destination ");
    print(destination);

    try {
      final ref = await firebase_storage.FirebaseStorage.instance
          .ref('$prefix')
          .child(unique.toString());
      await ref.putFile(_image!);
    } catch (e) {
      print('error occured');
    }
    images = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('$prefix${unique.toString()}')
        .getDownloadURL();
    print("images ");
    print(images);
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
