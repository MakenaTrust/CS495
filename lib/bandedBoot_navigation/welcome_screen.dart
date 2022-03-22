import 'package:flutter/material.dart';
// import 'custom/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(60.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // const Text(
                //   'Welcome to',
                //   style: TextStyle(
                //       fontSize: 40,
                //       color: Color(0xFF6634B0),
                //       fontWeight: FontWeight.bold),
                //   textAlign: TextAlign.center,
                // ),
                const SizedBox(
                  height: 5,
                ),
                Image.asset('assets/images/bandedNameLogo.png', scale: 3),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF6634B0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text('Log In'),
                  onPressed: () {
                    Navigator.pushNamed(context, 'login_screen');
                  },
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF6634B0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text('Register'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'accType_screen');
                    }),
              ]),
        ));
  }
}
