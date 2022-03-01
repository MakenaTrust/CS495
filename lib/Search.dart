import 'package:flutter/material.dart';
import 'package:flutter_application_1/searchDetailScreen.dart';

/*

*/
class Search extends StatefulWidget {
  @override
  _ExamplePageState createState() => new _ExamplePageState();
}

class _ExamplePageState extends State<Search> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List names = [];
  List filteredNames = [];
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search Example');

  _ExamplePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _appBarTitle,
        leading: IconButton(
          icon: _searchIcon,
          onPressed: _searchPressed,
        ),
      ),
      body: Container(
        child: _buildList(),
      ),
    );
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = [];
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            title: Text(filteredNames[index]),
            onTap: () => {
                  print(filteredNames[
                      index]), //HERE IS WHERE TO ADD BUTTON FUNCTIONALITY.
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SearchDetailScreen(text: filteredNames[index]),
                      ))
                });
      },
    );
  }

  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = Icon(Icons.close);
        _appBarTitle = TextField(
          controller: _filter,
          decoration: InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        _searchIcon = Icon(Icons.search);
        _appBarTitle = Text('Search Example');
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void _getNames() async {
    //here is where we'd need to get all the data from the database.
    List tempList = ['win', 'huh', 'literally', 'anyone', 'how', 'hug'];

    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }
}
