import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/custom/imagePicker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '/custom/Queries/eventTicketQuery.dart';
import '/custom/locationFinder.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

enum ImageSourceType { gallery, camera }

class EventCreationScreen extends StatefulWidget {
  // const EventCreationScreen({Key? key}) : super(key: key);
  String? picID;
  bool picked;

  EventCreationScreen({this.picID, required this.picked});
  @override
  _EventCreationScreenState createState() => _EventCreationScreenState();
}

class _EventCreationScreenState extends State<EventCreationScreen> {
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController eventStartTimeController = TextEditingController();
  TextEditingController eventEndTimeController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();
  TextEditingController eventCapacityController = TextEditingController();
  TextEditingController eventTypeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Events");
  String errorMessage = '';
  bool showSpinner = false;
  String currentSelectedValue = 'Music';
  File? _photo;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  ImagePicker picker = ImagePicker();
  String pic =
      'https://firebasestorage.googleapis.com/v0/b/wrist-bands.appspot.com/o/Events/48c12ce0-beaa-11ec-aadb-894fbd08ac93?alt=media&token=f69e83db-3407-40df-9527-c9b090afd731';

  // String type = "Music";

  // var types = [
  //   'Sports',
  //   'Sorority',
  //   'Other'
  // ];
  String docID = "";

  int index = 3; //CHANGE INDEX TO BE YOUR PAGE/PAGE YOU'RE ASSOCIATED WITH
  void _onItemTapped(int index, BuildContext context) {
    if (index == 0) Navigator.pushNamed(context, 'walletMain_screen');
    if (index == 1) Navigator.pushNamed(context, 'searchMain_screen');
    if (index == 2) Navigator.pushNamed(context, 'transferMain_screen');
    if (index == 3) Navigator.pushNamed(context, 'profileMain_screen');
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
        child: ListView(
          // inAsyncCall: showSpinner,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: FutureBuilder<String>(
                          future: getBand(
                              context, widget.picID.toString(), widget.picked),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Container(
                                height: 200,
                                width: 380,
                                padding: const EdgeInsets.all(8),
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: InkWell(
                                    splashColor: Colors.blue,
                                    onTap: () {
                                      debugPrint('Tapped');
                                    },
                                    child: ClipRRect(
                                      child: Image.network(
                                          (snapshot.data != null)
                                              ? snapshot.data.toString()
                                              : 'assets/images/blueBand.png',
                                          // height: 200,
                                          // width: 380,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
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
                        'Submit a ticket picture',
                      ),
                      onPressed: () {
                        _showPicker(context);
                      }),
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
                      onTap: () {
                        _selectDate(context);
                      }),
                  Center(
                    child: Text(errorMessage),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                      textAlign: TextAlign.center,
                      controller: eventStartTimeController,
                      //validator: validateEventDate,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Event Start Time',
                      ),
                      onTap: () {
                        _selectTime(context, "start");
                      }),
                  Center(
                    child: Text(errorMessage),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                      textAlign: TextAlign.center,
                      controller: eventEndTimeController,
                      //validator: validateEventDate,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Event End Time',
                      ),
                      onTap: () {
                        _selectTime(context, "end");
                      }),
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
                      controller: eventCapacityController,
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
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ]),
                  const SizedBox(
                    height: 8.0,
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Event Type',
                    ),
                    value: 'Please select an event type',
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: const [
                      DropdownMenuItem(
                        child: Text('Please select an event type'),
                        value: 'Please select an event type',
                      ),
                      DropdownMenuItem(
                          child: Text('Academic'), value: 'Academic'),
                      DropdownMenuItem(child: Text('Dance'), value: 'Dance'),
                      DropdownMenuItem(child: Text("Food"), value: "Food"),
                      DropdownMenuItem(
                          child: Text('Fraternity'), value: 'Fraternity'),
                      DropdownMenuItem(child: Text("Music"), value: "Music"),
                      DropdownMenuItem(
                          child: Text("Sorority"), value: "Sorority"),
                      DropdownMenuItem(child: Text("Sports"), value: "Sports")
                    ],
                    onChanged: (value) {
                      setState(() {
                        eventTypeController.text = value.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF6634B0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text('Register Event'),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                        errorMessage = '';
                      });
                      if (_formKey.currentState!.validate()) {
                        try {
                          FirebaseFirestore.instance.collection("Events").add({
                            "eventLocation": eventLocationController.text,
                            "Date": eventDateController.text,
                            "eventStartTime": eventStartTimeController.text,
                            "eventEndTime": eventEndTimeController.text,
                            "ticketFile": pic,
                            "EventName": eventNameController.text,
                            "SearchEventName":
                                eventNameController.text.toLowerCase(),
                            "capacity": eventCapacityController.text,
                            "eventType": eventTypeController.text,
                          }).then((value) {
                            for (int i = 0;
                                i < int.parse(eventCapacityController.text);
                                i++) {
                              addBlankTicketToEvent(value.id);
                            }
                          });
                          Navigator.pushNamed(
                              context, 'eventCreationSuccess_screen');
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.tickets),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.arrow_right_arrow_left),
              label: 'Transfer',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: 'Profile',
            ),
          ],
          currentIndex: index,
          selectedItemColor: Color(0xFF6634B0),
          onTap: (index) {
            _onItemTapped(index, context);
          }),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2121),
    );
    if (newSelectedDate != null) {
      setState(() {
        selectedDate = newSelectedDate;
        final f = DateFormat('yyyy-MM-dd');
        // final stamp = DateTime.parse(DateFormat.yMMMd().format(selectedDate));
        String date = f.format(selectedDate);
        eventDateController.text = date;
        print(eventDateController);
        // eventDateController = newSelectedDate as TextEditingController;
      });
    }
  }

  _selectTime(BuildContext context, String startOrEnd) async {
    TimeOfDay _selectedTime = TimeOfDay.now();
    TimeOfDay? newSelectedTime = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    ));
    _selectedTime = newSelectedTime!;
    String time = _selectedTime.toString();
    setState(() {
      if (startOrEnd == 'start') {
        eventStartTimeController =
            TextEditingController(text: time.substring(10, time.length - 1));
        print(eventStartTimeController);
      } else {
        eventEndTimeController =
            TextEditingController(text: time.substring(10, time.length - 1));
        print(eventEndTimeController);
      }
    });
  }

  void _handleGalButtonPress(BuildContext context, var type) {
    String file = 'band';
    _photo = Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ImageFromGalleryEx(
                  type,
                  file,
                ))) as File?;
  }

  Future<String> getBand(
      BuildContext context, String unique, bool picker) async {
    setState(() {
      // picker = true;
    });
    Image image;
    // String text =
    //     'https://www.holdenadvisors.com/wp-content/uploads/2017/04/blank-profile-picture-973460_960_720.png';
    // ;
    if (picker == false) unique = 'blueBand.png';
    // if (picker == false)
    // return 'https://www.holdenadvisors.com/wp-content/uploads/2017/04/blank-profile-picture-973460_960_720.png';
    // else
    //   debugPrint("in get pic");
    final images = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Events/${unique.toString()}');
    pic = await images.getDownloadURL();
    // filename = unique.toString() as TextEditingController;
    // print(pic);
    return pic;
    // debugPrint(pic);
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () {
                        _handleGalButtonPress(context, ImageSourceType.gallery);
                        Navigator.of(context).pop();
                      }),
                  ListTile(
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

  @override
  void dispose() {
    super.dispose();
    // nameController.dispose();
    eventNameController.dispose();
    eventDateController.dispose();
    eventStartTimeController.dispose();
    eventEndTimeController.dispose();
    eventCapacityController.dispose();
    eventLocationController.dispose();
    eventTypeController.dispose();
    // ageController.dispose();
  }
}
