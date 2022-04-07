import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/bandedBoot_navigation/registration_navigation/signup_screen.dart';
// import 'package:firebase_storage/firebase_storage.dart';
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
          title: Text(type == ImageSourceType.camera
              ? "Image from Camera"
              : "Image from Gallery")),
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
                  await uploadFile();
                });
              },
              child: ClipOval(
                // width: 200,
                // height: 200,
                // decoration: BoxDecoration(color: Colors.red[200]),
                child: _image != null
                    ? Image.file(
                        _image,
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        decoration: BoxDecoration(color: Colors.red[200]),
                        width: 200,
                        height: 200,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
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
    String images = await firebase_storage.FirebaseStorage.instance
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
