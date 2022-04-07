import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import '/custom/ticketCreation.dart';
import '/custom/userQuery.dart';
import '/custom/ticketUtils.dart';

Future<List<TicketInfo>> makeTicketList() async {
  List<TicketInfo> ticketlist =
      await getUserCurEventList('28CilJAsu2fYIeozyadCgRVBhdx2');
  return ticketlist;
}

void convertFutureListToList() async {
  Future<List<TicketInfo>> _futureOfList =
      getUserCurEventList('28CilJAsu2fYIeozyadCgRVBhdx2');
  List<TicketInfo> list = await _futureOfList;
  print('ConvertList list @ build is length ' + list.length.toString());
}

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  int index = 2; //CHANGE INDEX TO BE YOUR PAGE/PAGE YOU'RE ASSOCIATED WITH
  void _onItemTapped(int index, BuildContext context) {
    if (index == 0) Navigator.pushNamed(context, 'walletMain_screen');
    if (index == 1) Navigator.pushNamed(context, 'searchMain_screen');
    if (index == 2) Navigator.pushNamed(context, 'sendReceiveMain_screen');
    if (index == 3) Navigator.pushNamed(context, 'profileMain_screen');
  }

  String errormessage = 'none';
  int numTickets = 0;
  String testUser = '28CilJAsu2fYIeozyadCgRVBhdx2';
  String testTicket = 'egdmA8ioxvawWJKvY0vQ';

  // Future<List<TicketInfo>> _ticketList;
  List<TicketInfo> ticketlist = [];

  String ticket0Sender = 'ticket0Owner';
  String ticket0Event = 'ticket0Event';
  String ticket1Sender = 'ticket1Sender';
  String ticket1Event = 'ticket1Event';
  String ticket2Sender = 'ticket2Sender';
  String ticket2Event = 'ticket2Event';
  String ticket3Sender = 'ticket3Sender';
  String ticket3Event = 'ticket3Event';
  //UserQuery currentUser = UserQuery();

/*
  @override
  void initState() {
    super.initState();
    _ticketlist = getUserCurEventList(testUser);
  }
  */

  @override
  Widget build(BuildContext context) {
    convertFutureListToList();
    ticketlist = [];
    print(
        'TransferState list @ build is length ' + ticketlist.length.toString());

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/bandedLogo.png', scale: 15),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF6634B0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text('Send Wristband'),
                    onPressed: () {
                      numTickets++;
                      //setTicketCode(testUser, testTicket, 'Place', 'Dude');
                      setState(() {});
                      /*async {
                      try {
                        addTicket();
                      } catch (e) {
                        errormessage = 'failed to create ticket';
                      }*/
                    }),
                Text(
                  numTickets.toString() + ' received Wristbands',
                  textAlign: TextAlign.center,
                  textScaleFactor: 2,
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.account_circle,
                        ),
                        title: Text(ticket1Event),
                        subtitle: Text('from: ' + ticket1Sender),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('ACCEPT'),
                            onPressed: () {
                              ticket1Sender = 'ticket1sender';
                              setState(() {});
                            },
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            child: const Text('DENY'),
                            onPressed: () {
                              ticket1Sender = 'denied';
                              setState(() {});
                            },
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ])),
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
