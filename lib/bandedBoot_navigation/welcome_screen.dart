import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'custom/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Position? _position;
  LocationPermission? permission;

  // void _getCurrentLocation() async {
  //   Position position = await _determinePosition();
  //   setState(() {
  //     _position = position;
  //   });
  // }

  _determinePosition() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: false)
        .then((Position position) {
      print(position);
      setState(() {
        _position = position;
        print(position.latitude);
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();

    _determinePosition();
    //until this is completed user stays null we can use it to check whether it's loaded
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
