import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
  final String name;
  Wallet({Key? key, required this.name}) : super(key: key) {
    globalName = name;
  }

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
        if (globalName == 'nothing') ...[
          Container(
            constraints: BoxConstraints.expand(
              height: Theme.of(context).textTheme.headline4!.fontSize! * 1.1 +
                  200.0,
            ),
            padding: const EdgeInsets.all(8.0),
            color: Colors.blue[600],
            alignment: Alignment.center,
            child: Text('You have no Wristbands',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.white)),
          ),
        ] else ...[
          Card(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Text(globalName),
            QrImage(
              data: globalName,
              version: QrVersions.auto,
              size: 200.0,
            ),
            TextButton(
                onPressed: () => setState(() => globalName = 'nothing'),
                child: const Text('Scan'))
          ]))
        ],
      ]),
      backgroundColor: Colors.blueGrey.shade200,
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => isEmpty = !isEmpty),
        tooltip: 'Flip',
        child: const Icon(Icons.add),
      ),
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
