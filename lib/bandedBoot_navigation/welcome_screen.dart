import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '/custom/locationQuery.dart';
// import 'custom/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Position? _position;
  LocationPermission? permission;
  LocationQuery x = LocationQuery();

  @override
  void initState() {
    super.initState();
    // LocationQuery x = LocationQuery();
    // EventQuery y = EventQuery();
    x.determinePosition().then((Position result) {
      setState(() {
        _position = result;
        print("hi " + _position.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // _determinePosition();
    debugPrint("Permission. " + permission.toString());
    debugPrint("Location. " + _position.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 5,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child:
                    Image.asset('assets/images/bandedNameLogo.png', scale: 3)),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF6634B0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text('Log In'),
                  onPressed: () {
                    Navigator.pushNamed(context, 'login_screen');
                  },
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF6634B0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text('Register'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'registration_screen');
                    })),
          ]),
    );
  }
}
