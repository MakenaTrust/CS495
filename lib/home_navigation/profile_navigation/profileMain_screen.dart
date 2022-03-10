import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

//comment

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  getUser() async {
    final _auth = FirebaseAuth.instance;
    final user1 = _auth.currentUser;
    final userid = user1?.uid;

    print(userid);
    return userid.toString();
  }

  String fname = " ";
  String lname = " ";
  String uName = " ";
  bool coordinator = false;

  Future<void> fetchAllContact() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((user) {
      setState(() {
        fname = user.data()!['firstName'];
        lname = user.data()!['lastName'];
        uName = user.data()!['username'];
        coordinator = user.data()!['holder'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAllContact();
    // fetchAllContact().then((String list) {
    //   setState(() {
    //     contactList = list;
    //   });
    // });
  }

  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Users");
  String errorMessage = '';

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
                Image.asset(
                  'assets/images/profileTemp.png',
                  height: 100,
                  width: 100,
                ),
                Text(
                  '$uName',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '$fname' + ' ' + '$lname',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                if (coordinator == true) ...{
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
                },
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    child: Text('Log Out'),
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, 'welcome_screen');
                        errorMessage = '';
                      } on FirebaseAuthException catch (error) {
                        errorMessage = error.message!;
                      }
                    }),
              ]),
        ));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
