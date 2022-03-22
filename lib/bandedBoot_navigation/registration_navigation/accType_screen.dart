import 'package:flutter/material.dart';
// import 'custom/rounded_button.dart';

class AccTypeScreen extends StatefulWidget {
  const AccTypeScreen({Key? key}) : super(key: key);

  @override
  _AccTypeScreenState createState() => _AccTypeScreenState();
}

class _AccTypeScreenState extends State<AccTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/bandedLogo.png', scale: 15),
          leading: const BackButton(
            color: Color(0xFF6634B0),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Are you a Visitor or a Coordinator?',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 69, 65, 73),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF6634B0),
                      fixedSize: const Size(80, 160),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text(
                    'Visitor',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'registration_screen');
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF6634B0),
                        fixedSize: const Size(80, 160),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text(
                      'Coordinator',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'holder_screen');
                    }),
              ]),
        ));
  }
}
