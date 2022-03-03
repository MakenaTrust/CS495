import 'package:flutter/material.dart';
import 'package:flutter_application_1/Wallet.dart';

class SearchDetailScreen extends StatelessWidget {
  final String text;
  const SearchDetailScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  text,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Text('Purchase and go to Wallet'),
                  onPressed: () {
                    //Navigator.pushNamed(context, 'home_screen');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Wallet(name: text),
                        ));
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Text('Cancel purchase'),
                  onPressed: () {
                    //Navigator.pushNamed(context, 'home_screen');
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Text('Back'),
                  onPressed: () {
                    //Navigator.pushNamed(context, 'home_screen');
                    Navigator.pop(context);
                  },
                )
              ]),
        ));
  }
}