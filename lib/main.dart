// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package: date_time_field/new_task_form.dart';

import 'welcome_screen.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'home_screen.dart';
import 'accType_screen.dart';
import 'holder_screen.dart';
import 'eventCreation_screen.dart';
import 'eventCreationSuccess_screen.dart';
import 'Profile.dart';

/*
//THIS IS HOW YOU ARE ABLE TO CREATE AN ACCOUNT AND IT AUTOMATICALLY LINKS TO FIREBASE. CAN LOG IN AND OUT

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AuthApp());
}

class AuthApp extends StatefulWidget {
  const AuthApp({Key? key}) : super(key: key);

  @override
  _AuthAppState createState() => _AuthAppState();
}

class _AuthAppState extends State<AuthApp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:
              Text('Auth User (Logged ' + (user == null ? 'out' : 'in') + ')'),
        ),
        body: Form(
          key: _key,
          child: Center(
            child: Column(
              children: [
                TextFormField(
                    controller: emailController, validator: validateEmail),
                TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: validatePassword),
                //USE THIS IF YOU WANT PASSWROD TO NOT SHOW
                //TextField(controller: passwordController, obscureText: true,),
                Center(
                  child: Text(errorMessage),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        child: Text('Sign Up'),
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              errorMessage = '';
                            } on FirebaseAuthException catch (error) {
                              errorMessage = error.message!;
                            }
                            setState(() {});
                          }
                        }),
                    ElevatedButton(
                        child: Text('Sign In'),
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              errorMessage = '';
                            } on FirebaseAuthException catch (error) {
                              errorMessage = error.message!;
                            }
                            setState(() {});
                          }
                        }),
                    ElevatedButton(
                        child: Text('Log Out'),
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance.signOut();
                            errorMessage = '';
                          } on FirebaseAuthException catch (error) {
                            errorMessage = error.message!;
                          }
                          setState(() {});
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'E-mail address is required.';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';
  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty)
    return 'Password is required.';

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword))
    return '''
      Password must be at least 8 characters,
      include an uppercase letter, number, and symbol.
      ''';
  return null;
}
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AuthApp());
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
        'accType_screen': (context) => AccTypeScreen(),
        'registration_screen': (context) => RegistrationScreen(),
        'login_screen': (context) => LoginScreen(),
        'holder_screen': (contect) => HolderScreen(),
        'home_screen': (context) => const HomeScreen(
              title: '',
            ),
        'eventCreation_screen': (context) => EventCreationScreen(),
        'eventCreationSuccess_screen': (context) =>
            EventCreationSuccessScreen(),
        'Profile': (context) => Profile(),
      },
      // home: const MyHomePage(title: 'Wrist Bands'),
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