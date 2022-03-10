import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/home_navigation/searchDetail_screen.dart';

/*

*/
class Search extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
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
  List names = [];

  List filteredNames = [];
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(null),
          onPressed: () {
            // Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: const InputDecoration(
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
              ? const Center(child: const CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
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
                          child: Row(
                            children: <Widget>[
                              // Image.network(
                              //   data['imageUrl'],
                              //   width: 150,
                              //   height: 100,
                              //   fit: BoxFit.fill,
                              // ),
                              const SizedBox(
                                width: 40,
                                height: 60,
                              ),
                              Text(
                                data['EventName'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
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

  //void _getNames() async {
  //here is where we'd need to get all the data from the database.
  //  List tempList = ['win', 'huh', 'literally', 'anyone', 'how', 'hug'];

  //  setState(() {
  //    names = tempList;
  //    names.shuffle();
  //    filteredNames = names;
  //  });
  // }
}
