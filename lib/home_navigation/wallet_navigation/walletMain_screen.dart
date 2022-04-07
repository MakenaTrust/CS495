import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/cupertino.dart';

/*
  bool setting = true;

  Flag({
    this.setting,
  });
}
*/

var isEmpty = true;
var isAvail = true;
String globalName = 'nothing';

class Wallet extends StatefulWidget {
  final String name = "nothing";
  Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int index = 0; //CHANGE INDEX TO BE YOUR PAGE/PAGE YOU'RE ASSOCIATED WITH
  void _onItemTapped(int index, BuildContext context) {
    if (index == 0) Navigator.pushNamed(context, 'walletMain_screen');
    if (index == 1) Navigator.pushNamed(context, 'searchMain_screen');
    if (index == 2) Navigator.pushNamed(context, 'sendReceiveMain_screen');
    if (index == 3) Navigator.pushNamed(context, 'profileMain_screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/bandedLogo.png', scale: 15),
        backgroundColor: Colors.white,
      ),
      body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
        if (globalName == 'nothing') ...[
          Container(
            height: 200,
            width: 380,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                splashColor: Colors.blue,
                onTap: () {
                  debugPrint('Tapped');
                },
                child: ClipRRect(
                  child: Image.asset('assets/images/san diego county fair.png',
                      scale: 1),
                ),
              ),
            ),
          ),
          Container(
            height: 200,
            width: 380,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                splashColor: Colors.blue,
                onTap: () {
                  debugPrint('Tapped');
                },
                child: ClipRRect(
                  child: Image.asset('assets/images/phi mu date party.png',
                      scale: 1),
                ),
              ),
            ),
          ),
          Container(
            height: 200,
            width: 380,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                splashColor: Colors.blue,
                onTap: () {
                  debugPrint('Tapped');
                },
                child: ClipRRect(
                  child: Image.asset(
                      'assets/images/sigma chi x waka flocka.png',
                      scale: 1),
                ),
              ),
            ),
          ),
          Container(
            height: 200,
            width: 380,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                splashColor: Colors.blue,
                onTap: () {
                  debugPrint('Tapped');
                },
                child: ClipRRect(
                  child: Image.asset('assets/images/chris lane concert.png',
                      scale: 1),
                ),
              ),
            ),
          )
        ] else ...[
          Container(
              height: 200,
              width: 380,
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Text(globalName),
                    QrImage(
                      data: globalName,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                    TextButton(
                        onPressed: () => setState(() => globalName = 'nothing'),
                        child: const Text('Scan'))
                  ])))
        ],
      ]),
      backgroundColor: Colors.white,
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => setState(() => isEmpty = !isEmpty),
      //   tooltip: 'Flip',
      //   child: const Icon(Icons.add),
      //),
    );
  }
}


/*
class TicketRoute extends StatefulWidget {
  const TicketRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<TicketRoute> createState() => _TicketState();
}


class _TicketState extends State<TicketRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.amber[600],
            child: Center(child: Text('Event available? $isAvail.')),
          ),
          Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const Text('Event#123'),
              TextButton(
                  onPressed: () {
                    isEmpty = false;
                    isAvail = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Wallet()),
                    );
                  },
                  child: const Text('Buy'))
            ]),
          ),
          if (isAvail) ...[
            Container(
              height: 50,
              color: Colors.amber[500],
              child: const Center(child: Text('Entry B')),
            ),
          ] else ...[
            OutlinedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: const Text('Go back')),
          ]
        ],
      ),
      backgroundColor: Colors.blueGrey.shade200,
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => isAvail = !isAvail),
        tooltip: 'Flip',
        child: const Icon(Icons.add),
      ),
    );
  }
}
*/
