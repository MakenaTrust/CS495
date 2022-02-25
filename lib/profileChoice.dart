import 'package:flutter/material.dart';
// import 'custom/rounded_button.dart';

class ProfileChoiceScreen extends StatefulWidget {
  const ProfileChoiceScreen({Key? key}) : super(key: key);

  @override
  _ProfileChoiceState createState() => _ProfileChoiceState();
}

class _ProfileChoiceState extends State<ProfileChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: const Text('Event Goer'),
                  onPressed: () {
                    // Navigator.pushNamed(context, 'registration_screen');
                  },
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    child: const Text('Event Holder'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'holder_screen');
                    }),
              ]),
        ));
  }
}
