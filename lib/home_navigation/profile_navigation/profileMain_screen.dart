import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:firebase_database/firebase_database.dart';
import '/custom/Queries/userQuery.dart';
import 'package:geolocator/geolocator.dart';
import '/custom/locationFinder.dart';

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
    if (index == 2) Navigator.pushNamed(context, 'transferMain_screen');
    if (index == 3) Navigator.pushNamed(context, 'profileMain_screen');
  }

  String fname = " ";
  String lname = " ";
  String uName = " ";
  String file = " ";
  late QuerySnapshot eventName;
  bool coordinator = false;
  Position? _position;

  @override
  void initState() {
    super.initState();
    UserQuery x = UserQuery();
    LocationQuery y = LocationQuery();
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
    x.fetchUserPicture().then((String result) {
      setState(() {
        file = result;
      });
    });
    y.determinePosition().then((Position result) {
      setState(() {
        _position = result;
        print("hi " + _position.toString());
      });
    });
  }

  // Position? position;

  late Future<Position> loc;

  String errorMessage = '';
  // UserQuery x = UserQuery();
  // late Future<String> first = x.fetchUserFirstName();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/bandedLogo.png', scale: 15),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CircleAvatar(
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: file,
                      // placeholder: (context, file) =>
                      //     CircularProgressIndicator(),
                      progressIndicatorBuilder: (context, url, progress) =>
                          LoadingAnimationWidget.hexagonDots(
                              color: Color(0xFF6634B0), size: 100),
                      //     child: ClipOval(
                      //         child: Image.network(
                      //             'https://www.holdenadvisors.com/wp-content/uploads/2017/04/blank-profile-picture-973460_960_720.png',
                      //             width: 150,
                      //             height: 150,
                      //             fit: BoxFit.cover)),
                      // radius: 100.0
                    ),
                  ),
                  // width: 100,
                  // height: 150,
                  // fit: BoxFit.cover
                  // ),
                  // child: ClipOval(
                  //     child: Image.network(file, loadingBuilder:
                  //         (BuildContext context, Widget child,
                  //             ImageChunkEvent? loadingProgress) {
                  //   if (loadingProgress == null) {
                  //     return child;
                  //   }
                  //   return CircleAvatar(
                  //     child: LoadingAnimationWidget.hexagonDots(
                  //         color: Color(0xFF6634B0), size: 100),
                  //   );
                  // }, width: 100, height: 150, fit: BoxFit.cover)),
                  radius: 50.0),
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
              Text(
                '',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                'Past Events:',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 200,
                width: 380,
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    splashColor: Colors.blue,
                    onTap: () {
                      debugPrint('Tapped');
                    },
                    child: ClipRRect(
                      child: Image.asset('assets/images/testBandPic.heic',
                          scale: 1),
                    ),
                  ),
                ),
              ),
              Text(
                '',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
