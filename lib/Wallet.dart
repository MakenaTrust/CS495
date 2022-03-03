import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

//import qrScanner_screen.dart

/*class Wallet extends StatelessWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Wallet here', style: Theme.of(context).textTheme.headline1),
    );
  }
}*/

var isEmpty = true;
var isAvail = true;

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

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
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.amber[600],
            child: Center(child: Text('Wallet empty? $isEmpty.')),
          ),
          OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TicketRoute()),
                );
              },
              child: const Text('Search events')),
          if (isEmpty) ...[
            Container(
              height: 50,
              color: Colors.amber[500],
              child: const Center(child: Text('No events yet')),
            ),
          ] else ...[
            Container(
              height: 50,
              color: Colors.amber[500],
              child: const Center(child: Text('Event#123')),
            ),
          ]
        ],
      ),
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
class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
*/

class TicketRoute extends StatefulWidget {
  const TicketRoute({Key? key}) : super(key: key);

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
                    Navigator.pop(
                      context,
                    );
                    isEmpty = false;
                    isAvail = false;
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
