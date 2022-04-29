import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'searchDetail_screen.dart';
import 'package:flutter_application_1/custom/text_utils.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import '/custom/ticketBuilder.dart';
import '/custom/userQuery.dart';

/*
*/
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<Search> {
  TextEditingController input = new TextEditingController();
  final TextUtils _textUtils = TextUtils();
  List names = [];

  List filteredNames = [];
  String name = "";
  bool clicked = false;
  String fname = " ";
  String lname = " ";
  TicketToBuild y = TicketToBuild();

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
    // clicked = false;
    // fullSearch(name);
  }

  int index = 1; //CHANGE INDEX TO BE YOUR PAGE/PAGE YOU'RE ASSOCIATED WITH
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
                  hintText: 'Search...',
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
                fullSearch(name);
              },
              onChanged: (val) {
                setState(() {
                  name = val;
                  // print(name);
                  fullSearch(name);
                  // });
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            // searchPageWidget(),
            // if (clicked == false) searchPageWidget() else fullSearch(name)
            if (clicked == false) searchPageWidget() else fullSearch(name)
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

  Widget searchPageWidget() {
    // print("searchpage");
    return Container(
      width: 800,
      child: StreamBuilder<QuerySnapshot>(
        stream: (name != "")
            ? FirebaseFirestore.instance
                .collection('Events')
                .where('SearchEventName',
                    isGreaterThanOrEqualTo: name.toLowerCase())
                .where('SearchEventName', isLessThan: name.toLowerCase() + 'z')
                .snapshots()
            : FirebaseFirestore.instance.collection("Events").snapshots(),
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
                    String EVID = snapshot.data!.docs[index].reference.id;
                    String UName = "$fname" + " " + "$lname";
                    String name = data['EventName'];
                    String pic = data['ticketFile'];
                    // String picName = pic + ".png";
                    String date = data['Date'];
                    // String capacity = data['capacity'];
                    return GestureDetector(
                        onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchDetailScreen(
                                        EVID: EVID,
                                        EVName: name,
                                        UName: UName,
                                        EVPicture: pic,
                                        EVDate: date),
                                  ))
                            },
                        child: SingleChildScrollView(
                          // child: Card(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 200,
                                width: 380,
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                                // child: Card(
                                child: InkWell(
                                  splashColor: const Color(0xFF6634B0),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SearchDetailScreen(
                                                  EVID: EVID,
                                                  UName: UName,
                                                  EVName: name,
                                                  EVPicture: pic,
                                                  EVDate: date),
                                        ));
                                  },
                                  child: Center(child: fullSearch(name)
                                      // Text('$name',
                                      //     textAlign: TextAlign.center),
                                      ),
                                ),
                              ),
                              // ),
                            ],
                          ),
                        ));
                  },
                );
        },
      ),
    );
  }

  Widget fullSearch(String name) {
    // print("fullsearch");
    return Container(
      width: 800,
      child: StreamBuilder<QuerySnapshot>(
        stream: (name != "")
            ? FirebaseFirestore.instance
                .collection('Events')
                .where('SearchEventName',
                    isGreaterThanOrEqualTo: name.toLowerCase())
                .where('SearchEventName', isLessThan: name.toLowerCase() + 'z')
                .snapshots()
            : FirebaseFirestore.instance.collection("Events").snapshots(),
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
                    String EVID = snapshot.data!.docs[index].reference.id;
                    String name = data['EventName'];
                    String pic = data['ticketFile'];
                    String date = data['Date'];
                    return y.ticketBuilder(name, " ", pic, date);
                  },
                );
        },
      ),
    );
  }
}

Widget renderPic(String pic, String name) {
  // String pic1 = pic.replaceAll(",", "");
  // String picName = pic + '.png';
  if (pic == null) {
    return Card(child: Text('$name', textAlign: TextAlign.center));
  } else
    return Image.network(pic,
        fit: BoxFit.fill,
        color: Color.fromRGBO(255, 255, 255, .86),
        colorBlendMode: BlendMode.modulate);
}
