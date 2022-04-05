import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:firebase_database/firebase_database.dart';
import '/custom/userQuery.dart';
import 'package:geolocator/geolocator.dart';

// import '/custom/eventQuery.dart';
// import 'package:image_picker/image_picker.dart';
// import '/home_navigation/Profile_navigation/profileUpdate_screen.dart';
// import '/home_navigation/Profile_navigation/profileUpdateSuccess_screen.dart';

//comment

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // getUser() async {
  //   final _auth = FirebaseAuth.instance;
  //   final user1 = _auth.currentUser;
  //   final userid = user1?.uid;

  //   print(userid);
  //   return userid.toString();
  // }

  int index = 3; //CHANGE INDEX TO BE YOUR PAGE/PAGE YOU'RE ASSOCIATED WITH
  void _onItemTapped(int index, BuildContext context) {
    if (index == 0) Navigator.pushNamed(context, 'walletMain_screen');
    if (index == 1) Navigator.pushNamed(context, 'searchMain_screen');
    if (index == 2) Navigator.pushNamed(context, 'sendReceiveMain_screen');
    if (index == 3) Navigator.pushNamed(context, 'profileMain_screen');
  }

  String fname = " ";
  String lname = " ";
  String uName = " ";
  late QuerySnapshot eventName;
  bool coordinator = false;

  @override
  void initState() {
    super.initState();
    UserQuery x = UserQuery();
    // EventQuery y = EventQuery();
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
        uName = result;
      });
    });
    x.fetchUserHolder().then((bool result) {
      setState(() {
        coordinator = result;
      });
    });
    // y.fetchEventName().then((QuerySnapshot result) {
    //   setState(() {
    //     eventName = result;
    //   });
    //   print(result.docs);
    // });
  }

  Future<Position> _position = Geolocator.getCurrentPosition();
  Position? position;
  LocationPermission? permission;
  late Future<Position> loc;

  void _getCurrentLocation() async {
    position = await _determinePosition();
    print("5." + position.toString());
    setState(() {
      _position = position as Future<Position>;
    });
  }

  Future<Position> _determinePosition() async {
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }
    // print("3." + loc.toString());
    loc = (await Geolocator.getCurrentPosition()) as Future<Position>;
    return Geolocator.getCurrentPosition();
  }

  Future<Position> _getLoc() async {
    loc = (await Geolocator.getCurrentPosition()) as Future<Position>;
    return loc;
  }

  // DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Users");
  String errorMessage = '';
  // UserQuery x = UserQuery();
  // late Future<String> first = x.fetchUserFirstName();
  @override
  Widget build(BuildContext context) {
    _getLoc();
    debugPrint("hi");
    debugPrint("3. " + permission.toString());
    debugPrint("4." + position.toString());
    // debugPrint('2. ' + _position.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                // '$fname' + ' ' + '$lname' + ' ' + '$eventName',
                '$fname' + ' ' + '$lname',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              if (coordinator == true) ...{
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF6634B0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text('Create Event'),
                  onPressed: () {
                    Navigator.pushNamed(context, 'eventCreation_screen');
                  },
                ),
              },
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF6634B0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text('Log Out'),
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushNamed(context, 'welcome_screen');
                      errorMessage = '';
                    } on FirebaseAuthException catch (error) {
                      errorMessage = error.message!;
                    }
                  }),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF6634B0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text('Update Profile'),
                  onPressed: () async {
                    try {
                      Navigator.pushNamed(context, 'profileUpdate_screen');
                      errorMessage = '';
                    } on FirebaseAuthException catch (error) {
                      errorMessage = error.message!;
                    }
                  }),
            ]),
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

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
