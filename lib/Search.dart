import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'DataController.dart';

/*

*/
class Search extends StatefulWidget {
  @override
  _ExamplePageState createState() => new _ExamplePageState();
}

// class DataModel{
//     final String? userName;
//     DataModel({this.userName});

//     List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot){
//     return querySnapshot.docs.map((snapshot)){
//       final Map<String, dynamic> dataMap = snapshot.data() as Map<String, dynamic>;

//       return DataModel(
//         userName: dataMap['userName']);
//     }).toList();
//   }
// }

class _ExamplePageState extends State<Search> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List names = [];

  List filteredNames = [];
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search Example');
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(null),
          onPressed: () {
            // Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    return Card(
                      child: Row(
                        children: <Widget>[
                          // Image.network(
                          //   data['imageUrl'],
                          //   width: 150,
                          //   height: 100,
                          //   fit: BoxFit.fill,
                          // ),
                          SizedBox(
                            width: 40,
                            height: 60,
                          ),
                          Text(
                            data['EventName'],
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
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

  // Widget _buildList() {
  //   if (!(_searchText.isEmpty)) {
  //     List tempList = [];
  //     for (int i = 0; i < filteredNames.length; i++) {
  //       if (filteredNames[i]
  //           .toLowerCase()
  //           .contains(_searchText.toLowerCase())) {
  //         tempList.add(filteredNames[i]);
  //       }
  //     }
  //     filteredNames = tempList;
  //   }
  //   return ListView.builder(
  //     itemCount: names == null ? 0 : filteredNames.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return ListTile(
  //         title: Text(filteredNames[index]),
  //         onTap: () => print(filteredNames[index]),
  //       );
  //     },
  //   );
  // }

  // void _searchPressed() {
  //   setState(() {
  //     if (_searchIcon.icon == Icons.search) {
  //       _searchIcon = Icon(Icons.close);
  //       _appBarTitle = TextField(
  //         controller: _filter,
  //         decoration: InputDecoration(
  //             prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
  //       );
  //     } else {
  //       _searchIcon = Icon(Icons.search);
  //       _appBarTitle = Text('Search Example');
  //       filteredNames = names;
  //       _filter.clear();
  //     }
  //   });
  // }

  // void _getNames() async {
  //   //final response = await Dio().get('https://swapi.co/api/people');

  //   List tempList = ['win', 'huh', 'literally', 'anyone', 'how', 'hug'];
  //   //for (int i = 0; i < response.data.length; i++) {
  //   //  tempList.add(response.data[i]);
  //   //}
  //   setState(() {
  //     names = tempList;
  //     names.shuffle();
  //     filteredNames = names;
  //   });
  // }
}
