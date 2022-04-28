import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/home_navigation/search_navigation/searchDetail_screen.dart';
import 'package:flutter_application_1/custom/text_utils.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import '/custom/userQuery.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*

*/
class SearchUserScreen extends StatefulWidget {
  // const SearchUser({Key? key}) : super(key: key);
  String evid;
  String tid;
  SearchUserScreen({Key? key, required this.evid, required this.tid});
  @override
  _SearchUserScreenState createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  @override
  void initState() {
    super.initState();
    // UserQuery x = UserQuery();
    // // EventQuery y = EventQuery();
    // x.fetchUserFirstName().then((String result) {
    //   setState(() {
    //     fname = result;
    //   });
    // });
    // x.fetchUserLastName().then((String result) {
    //   setState(() {
    //     lname = result;
    //   });
    // });
    // clicked = false;
    // nameSearch(name);
  }

  TextEditingController input = new TextEditingController();
  String name = "";
  bool clicked = false;
  int index = 2; //CHANGE INDEX TO BE YOUR PAGE/PAGE YOU'RE ASSOCIATED WITH
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
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: input,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6634B0)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6634B0)),
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {
                      // setState(() {});
                    },
                    icon: const Icon(Icons.search, color: Color(0xFF6634B0)),
                  ),
                  hintText: 'Search username...',
                  suffixIcon: IconButton(
                    onPressed: () {
                      clicked = false;
                      input.clear();
                      setState(() {
                        name = '';
                        clicked = false;
                        // initState();
                      });
                    },
                    icon: const Icon(Icons.close, color: Color(0xFF6634B0)),
                  )),
              onTap: () {
                clicked = true;
                nameSearch(name);
              },
              onChanged: (val) {
                setState(() {
                  name = val;
                  print(name);
                  nameSearch(name);
                  // });
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            nameSearch(name)
            // searchPageWidget(),
            // if (clicked == false) searchPageWidget() else nameSearch(name)
            // if (clicked == false) searchPageWidget() else nameSearch(name)
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

  Widget nameSearch(String name) {
    return Container(
      width: 800,
      // height: 8000,
      child: StreamBuilder<QuerySnapshot>(
        stream: (name != "")
            ? FirebaseFirestore.instance
                .collection('Users')
                .where('searchUser', isGreaterThanOrEqualTo: name.toLowerCase())
                .where('searchUser', isLessThan: name.toLowerCase() + 'z')
                .snapshots()
            : FirebaseFirestore.instance.collection("Users").snapshots(),
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
                    String fname = data['firstName'];
                    String lname = data['lastName'];
                    String transferringTo = data.reference.id;
                    String transferringFrom =
                        FirebaseAuth.instance.currentUser!.uid;
                    // print('To: ${transferringTo}');
                    // print('From: ${transferringFrom}');
                    return Card(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 200,
                            width: 380,
                            // width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: Card(
                              semanticContainer: true,
                              child: InkWell(
                                splashColor: const Color(0xFF6634B0),
                                onTap: () {
                                  print("EVID " + widget.evid.toString());
                                  print("TID " + widget.tid.toString());
                                  print('To: ${transferringTo}');
                                  print('From: ${transferringFrom}');
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           SearchDetailScreen(
                                  //               text: data['EventName']),
                                  //     ));
                                },
                                child: Stack(children: <Widget>[
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    right: 10,
                                    child: Text('${fname} ${lname}'),
                                    // Text('$name',
                                    //     textAlign: TextAlign.center),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
