import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/home_navigation/wallet_navigation/walletMain_screen.dart';

class SearchDetailScreen extends StatelessWidget {
  final String EVID;
  final String EVName;
  final String EVPicture;
  final String EVDate;
  SearchDetailScreen(
      {Key? key,
      required this.EVID,
      required this.EVName,
      required this.EVPicture,
      required this.EVDate})
      : super(key: key);
  int index = 1;

  void _onItemTapped(int index, BuildContext context) {
    if (index == 0) Navigator.pushNamed(context, 'walletMain_screen');
    if (index == 1) Navigator.pushNamed(context, 'searchMain_screen');
    if (index == 2) Navigator.pushNamed(context, 'TransferMain_screen');
    if (index == 3) Navigator.pushNamed(context, 'profileMain_screen');
  }

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
              Text(
                EVID,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF6634B0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: const Text('Purchase and go to Wallet'),
                onPressed: () {
                  //Navigator.pushNamed(context, 'home_screen');
                  Navigator.pushNamed(context, 'walletMain_screen');
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF6634B0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: const Text('Cancel purchase'),
                onPressed: () {
                  //Navigator.pushNamed(context, 'home_screen');
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF6634B0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: const Text('Back'),
                onPressed: () {
                  //Navigator.pushNamed(context, 'home_screen');
                  Navigator.pop(context);
                },
              )
            ]),
      ),
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
          currentIndex: index,
          selectedItemColor: Color(0xFF6634B0),
          onTap: (index) {
            _onItemTapped(index, context);
          }),
    );
  }
}

Widget renderPic(String pic, String name) {
  // String pic1 = pic.replaceAll(",", "");
  // String picName = pic + '.png';
  if (pic == null) {
    return Card(child: Text('$name', textAlign: TextAlign.center));
  } else
    return Image.network(pic,
        fit: BoxFit.fill,
        color: Color.fromRGBO(255, 255, 255, .86),
        colorBlendMode: BlendMode.modulate);
}
