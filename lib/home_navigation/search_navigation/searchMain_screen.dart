import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/home_navigation/searchDetail_screen.dart';
import 'package:flutter_application_1/custom/text_utils.dart';

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

  @override
  void initState() {
    super.initState();
    // clicked = false;
    // fullSearch(name);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  icon: Icon(Icons.search, color: Color(0xFF6634B0)),
                ),
                hintText: 'Search...',
                suffixIcon: IconButton(
                  onPressed: () {
                    clicked = false;
                    input.clear();
                    setState(() {});
                  },
                  icon: Icon(Icons.close, color: Color(0xFF6634B0)),
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
    );
  }

  // Widget searchBarWidget() {
  //   return Container(
  //   height: 40,
  //   width: MediaQuery.of(context).size.width,
  //   margin: const EdgeInsets.only(left: 10, right: 10),
  //   decoration: BoxDecoration(
  //       border: Border.all(),
  //       borderRadius: BorderRadius.circular(30),
  //       color: const Color(0xFFFFFF)),
  //   child: Row(
  //     children: [
  //       const Expanded(
  //         child: Icon(
  //           Icons.search_rounded,
  //           color: Colors.black,
  //         ),
  //         flex: 1,
  //       ),
  //       Expanded(
  //         child: _textUtils.normal16("Search", const Color(0xFF3E3E3E)),
  //         flex: 6,
  //       )
  //     ],
  //   ),
  // );

  // child: TextField(
  //   decoration: const InputDecoration(
  //       prefixIcon: Icon(Icons.search), hintText: 'Search...'),
  //   onTap: () {
  //     clicked = true;
  //     fullSearch();
  //   },
  //   onChanged: (val) {
  //     setState(() {
  //       name = val;
  //     });
  //   },
  // ),

  //     child: IconButton(
  //       onPressed:() => Navigator.of(context).push(MaterialPageRoute(builder: (_) =>))
  //     ),
  //   );
  // }

  Widget searchPageWidget() {
    // print("searchpage");
    return Container(
      height: 200,
      width: 380,
      // width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        child: InkWell(
          splashColor: Color(0xFF6634B0),
          onTap: () {
            debugPrint('Tapped');
          },
          child: ClipRRect(
            child: Image.asset('assets/images/testBandPic.heic', scale: 1),
          ),
        ),
      ),
    );
  }

  Widget fullSearch(String name) {
    // print("fullsearch");
    return Container(
      width: 800,
      height: 800,
      child: StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
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
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    String name = data['EventName'];
                    // String date = data['Date'];
                    // String capacity = data['capacity'];
                    return GestureDetector(
                        onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchDetailScreen(
                                        text: data['EventName']),
                                  ))
                            },
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 200,
                                width: 380,
                                // width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Card(
                                  child: InkWell(
                                    splashColor: Color(0xFF6634B0),
                                    onTap: () {
                                      debugPrint('Tapped');
                                    },
                                    child: Center(
                                      child: Text('$name',
                                          textAlign: TextAlign.center),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                );
        },
      ),
    );
  }
}

/*          stream: (name != "" && name != null)
 //             ? FirebaseFirestore.instance
 //                 .collection('Events')
 //                 .where('SearchEventName',
 //                     isGreaterThanOrEqualTo: name.toLowerCase())
 //                 .where('SearchEventName', isLessThan: name.toLowerCase() + 'z')
 //                 .snapshots()
 //             : FirebaseFirestore.instance.collection("Events").snapshots(),
 //         builder: (context, snapshot) {
 //           return (snapshot.connectionState == ConnectionState.waiting)
 //               ? const Center(child: const CircularProgressIndicator())
 //               : ListView.builder(
 //                   itemCount: snapshot.data!.docs.length,
 //                   itemBuilder: (context, index) {
 //                     DocumentSnapshot data = snapshot.data!.docs[index];
 //                     return GestureDetector(
 //                         onTap: () => {
 //                               Navigator.push(
 //                                   context,
 //                                   MaterialPageRoute(
 //                                     builder: (context) => SearchDetailScreen(
 //                                         text: data['EventName']),
 //                                   ))
 //                             },*/
