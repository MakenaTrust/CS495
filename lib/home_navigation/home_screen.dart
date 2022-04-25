// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'wallet_navigation/walletMain_screen.dart';
import 'search_navigation/searchMain_screen.dart';
import 'profile_navigation/profileMain_screen.dart';
import 'transfer_navigation/transferMain_screen.dart';

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
  late Widget _Transfer;
  late Widget _Profile;
  late int selectedIndex;
  late Widget _currPage;
  late int pageNum = 0;

  @override
  void initState() {
    // print(pageNum);
    super.initState();
    _Wallet = Wallet();
    _Search = Search();
    _Transfer = Transfer();
    _Profile = Profile();
    Pages = [_Wallet, _Search, _Transfer, _Profile];
    selectedIndex = pageNum;
    _currPage = _Wallet;
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
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
        title: Image.asset('assets/images/bandedLogo.png', scale: 15),
        backgroundColor: Colors.white,
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
              label: 'Transfer',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF6634B0),
          onTap: (index) {
            _onItemTapped(index);
          }),
    );
  }
}
