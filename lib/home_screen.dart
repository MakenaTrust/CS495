import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Wallet.dart';
import 'Search.dart';
import 'Profile.dart';
import 'SendReceive.dart';

User? loggedinUser;

class HomeScreen extends StatefulWidget {
  const HomeScreen({this.uid, required this.title});

  final String? uid;
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  late List<Widget> Pages;
  late Widget _Wallet;
  late Widget _Search;
  late Widget _SendReceive;
  late Widget _Profile;
  late int selectedIndex;
  late Widget _currPage;
  late int pageNum = 0;

  @override
  void initState() {
    print(pageNum);
    super.initState();
    _Wallet = Wallet(name: 'nothing');
    _Search = Search();
    _SendReceive = const SendReceive();
    _Profile = Profile();
    Pages = [_Wallet, _Search, _SendReceive, _Profile];
    selectedIndex = pageNum;
    _currPage = _Wallet;
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _currPage = Pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _currPage,
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
              label: 'Send/Receive',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blueAccent[800],
          onTap: (index) {
            _onItemTapped(index);
          }),
    );
  }
}
