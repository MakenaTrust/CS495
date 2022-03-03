import 'package:flutter/material.dart';
// import 'custom/rounded_button.dart';

class AccTypeScreen extends StatefulWidget {
  @override
  _AccTypeScreenState createState() => _AccTypeScreenState();
}

class _AccTypeScreenState extends State<AccTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Are you a visitor or coordinator?',
                    textAlign: TextAlign.center),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Text('Visitor'),
                  onPressed: () {
                    Navigator.pushNamed(context, 'registration_screen');
                  },
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    child: Text('Coordinator'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'holder_screen');
                    }),
              ]),
        ));
  }
}
