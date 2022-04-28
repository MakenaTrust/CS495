import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/custom/imageQuery.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '/custom/userQuery.dart';
import 'searchUser_screen.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class OwnedTicketsScreen extends StatefulWidget {
  // const EventCreationScreen({Key? key}) : super(key: key);
  // String? picID;
  // bool picked;

  // OwnedTicketsScreen({this.picID, required this.picked});
  @override
  _OwnedTicketsScreenState createState() => _OwnedTicketsScreenState();
}

class _OwnedTicketsScreenState extends State<OwnedTicketsScreen> {
  int index = 2; //CHANGE INDEX TO BE YOUR PAGE/PAGE YOU'RE ASSOCIATED WITH
  void _onItemTapped(int index, BuildContext context) {
    if (index == 0) Navigator.pushNamed(context, 'walletMain_screen');
    if (index == 1) Navigator.pushNamed(context, 'searchMain_screen');
    if (index == 2) Navigator.pushNamed(context, 'transferMain_screen');
    if (index == 3) Navigator.pushNamed(context, 'profileMain_screen');
  }

  String uname = " ";
  String fname = " ";
  String lname = " ";
  String uid = " ";

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
    // fullSearch(name);
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
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        allOwned(FirebaseAuth.instance.currentUser!.uid)
      ])),
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

  Widget allOwned(uid) {
    // print("fullsearch");
    // print('fullSearch' + name);
    return GestureDetector(
      child: Container(
        width: 800,
        height: 800,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(uid)
              .collection("curEvents")
              .snapshots(),
          builder: (context, snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting)
                ? const Center(child: const CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data!.docs[index];
                      String evid = data['EVID'];
                      String ticketID = data.reference.id;
                      return GestureDetector(
                        // child: Card(
                        child: Column(
                          children: <Widget>[
                            Container(
                                height: 200,
                                width: 380,
                                // width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Card(
                                    child: Stack(children: <Widget>[
                                  Text(evid),
                                  Positioned(
                                      bottom: 1,
                                      // left: 10,
                                      right: 10,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: const Color(0xFF6634B0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        child: const Text('Send'),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchUserScreen(
                                                        evid: evid,
                                                        tid: ticketID,
                                                      )));
                                        },
                                      ))
                                ])))
                          ],
                        ),
                        // )
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
