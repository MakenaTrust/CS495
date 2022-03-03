import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class EventCreationScreen extends StatefulWidget {
  const EventCreationScreen({Key? key}) : super(key: key);

  @override
  _EventCreationScreenState createState() => _EventCreationScreenState();
}

class _EventCreationScreenState extends State<EventCreationScreen> {
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController eventTimeController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();
  TextEditingController eventCapacityController = TextEditingController();
  TextEditingController eventTypeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Users");
  String errorMessage = '';
  bool showSpinner = false;
  String currentSelectedValue = 'Music';

  // String type = "Music";

  // var types = [
  //   'Sports',
  //   'Sorority',
  //   'Other'
  // ];

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
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                  controller: eventTimeController,
                  //validator: validateEventDate,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Event Start Time',
                  ),
                  onTap: () {
                    _selectTime(context);
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
              ),
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
                  DropdownMenuItem(child: Text('Academic'), value: 'Academic'),
                  DropdownMenuItem(child: Text('Dance'), value: 'Dance'),
                  DropdownMenuItem(child: Text("Food"), value: "Food"),
                  DropdownMenuItem(
                      child: Text('Fraternity'), value: 'Fraternity'),
                  DropdownMenuItem(child: Text("Music"), value: "Music"),
                  DropdownMenuItem(child: Text("Sorority"), value: "Sorority"),
                  DropdownMenuItem(child: Text("Sports"), value: "Sports")
                ],
                onChanged: (value) {
                  setState(() {
                    eventTypeController.text = value.toString();
                  });
                },
              ),
              // TextFormField(
              //   textAlign: TextAlign.center,
              //   controller: eventTypeController,
              //   decoration: const InputDecoration(
              //     alignLabelWithHint: true,
              //     labelText: 'Type of Event',
              //   ),
              //   onTap: () {

              //   },
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Type of Event';
              //     }
              //     return null;
              //   },
              // ),
              const SizedBox(
                height: 8.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                child: const Text('Register Event'),
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                    errorMessage = '';
                  });
                  if (_formKey.currentState!.validate()) {
                    try {
                      FirebaseFirestore.instance
                          .collection("Events")
                          .doc(eventNameController.text)
                          .set({
                        "eventLocation": eventLocationController.text,
                        "Date": eventDateController.text,
                        "eventTime": eventTimeController.text,
                        "EventName": eventNameController.text,
                        "SearchEventName":
                            eventNameController.text.toLowerCase(),
                        "capacity": eventCapacityController.text,
                        "eventType": eventTypeController.text,
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
  _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2121),
    );
    if (newSelectedDate != null) {
      // eventDateController.text = DateFormat.yMMMd().format(selectedDate);
      // ..selection = TextSelection.fromPosition(TextPOsition())
// if (newSelectedDate != null && picked != selectedDate) {
      setState(() {
        selectedDate = newSelectedDate;
        final f = DateFormat('yyyy-MM-dd');
        // final stamp = DateTime.parse(DateFormat.yMMMd().format(selectedDate));
        String date = f.format(selectedDate);
        eventDateController.text = date;
        // eventDateController = newSelectedDate as TextEditingController;
      });
    }
  }

  _selectTime(BuildContext context) async {
    TimeOfDay _selectedTime = TimeOfDay.now();
    TimeOfDay? newSelectedTime = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      // firstDate: DateTime(2022),
      // lastDate: DateTime(2121),
      initialEntryMode: TimePickerEntryMode.input,
    ));
    _selectedTime = newSelectedTime!;
    String time = _selectedTime.toString();
    eventTimeController.text = time.substring(10, time.length - 1);
    // _selectedTime = newSelectedTime!;
    // eventDateController.text = DateFormat.yMMMd().format(_selectedTime);
    // ..selection = TextSelection.fromPosition(TextPOsition())
// if (newSelectedDate != null && picked != selectedDate) {
    setState(() {
      eventTimeController =
          time.substring(10, time.length - 1) as TextEditingController;
      // eventDateController = newSelectedTime as TextEditingController;
    });
  }

  // _dropDown(BuildContext context) async {
  //   DropdownButton<String>(
  //     items: [],
  //     onChanged: (String? val) {
  //       Text("works");
  //     },
  //   );
  // }

  @override
  void dispose() {
    super.dispose();
    // nameController.dispose();
    eventNameController.dispose();
    eventDateController.dispose();
    eventTimeController.dispose();
    eventCapacityController.dispose();
    eventLocationController.dispose();
    eventTypeController.dispose();
    // ageController.dispose();
  }
}
