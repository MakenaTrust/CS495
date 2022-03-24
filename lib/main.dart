// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package: date_time_field/new_task_form.dart';

import 'bandedBoot_navigation/welcome_screen.dart';
import 'bandedBoot_navigation/login_navigation/login_screen.dart';
import 'bandedBoot_navigation/registration_navigation/signup_screen.dart';
import 'home_navigation/home_screen.dart';
import 'bandedBoot_navigation/registration_navigation/accType_screen.dart';
import 'bandedBoot_navigation/registration_navigation/holder_screen.dart';
import 'home_navigation/profile_navigation/eventCreation_screen.dart';
import 'home_navigation/profile_navigation/eventCreationSuccess_screen.dart';
import 'home_navigation/profile_navigation/profileMain_screen.dart';
import 'home_navigation/profile_navigation/profileUpdate_screen.dart';
import 'home_navigation/profile_navigation/profileUpdateSuccess_screen.dart';
import 'home_navigation/wallet_navigation/walletMain_screen.dart';
import 'home_navigation/search_navigation/searchMain_screen.dart';
import 'home_navigation/sendReceive_navigation/sendReceiveMain_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WristBands',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'welcome_screen', //'welcome_screen',
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'accType_screen': (context) => const AccTypeScreen(),
        'registration_screen': (context) => RegistrationScreen(),
        'login_screen': (context) => const LoginScreen(),
        'holder_screen': (contect) => HolderScreen(),
        'home_screen': (context) => const HomeScreen(
              title: '',
            ),
        'eventCreation_screen': (context) => const EventCreationScreen(),
        'eventCreationSuccess_screen': (context) =>
            const EventCreationSuccessScreen(),
        'profileMain_screen': (context) => Profile(),
        'profileUpdate_screen': (context) => ProfileUpdateScreen(),
        'profileUpdateSuccess_screen': (context) =>
            ProfileUpdateSuccessScreen(),
        'searchMain_screen': (context) => Search(),
        'walletMain_screen': (context) => Wallet(),
        'sendReceiveMain_screen': (context) => SendReceive()
      },
    );
  }
}
/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  @override
  void initState() {
    super.initState();
    _Wallet = const Wallet();
    _Search = const Search();
    _SendReceive = const SendReceive();
    _Profile = const Profile();
    Pages = [_Wallet, _Search, _SendReceive, _Profile];
    selectedIndex = 0;
    _currPage = _Wallet;
  }

  /* This doesn't do anything? Commenting it out didn't seem to change anything but gonna leave it here just in case
  
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Profile',
      style: optionStyle,
    ),
  ];*/

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
*/