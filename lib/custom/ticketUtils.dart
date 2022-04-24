import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

//First 2 parameters take a uid and DOCid for locating the file
//Second 2 parameters are what make the code
Future<void> setTicketCode(
    String ownerID, String ticketID, String eventname, String username) async {
  String newcode = eventname + username;
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(ownerID)
      .collection('curEvents')
      .doc(ticketID)
      .update({'ticketCode': newcode});
}

class TicketInfo {
  String ownerID;
  String eventname;
  bool valid;

//Setters

  Future<void> setVisitorCurEvent(
    String UID,
    String TID,
    String EVID,
    String transferringTo,
    String transferringFrom,
  ) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(UID)
        .collection('curEvents')
        .doc(TID)
        .update({'EVID': EVID});
    ({'transferringTo': transferringTo});
    ({'transferringFrom': transferringFrom});
  }

  Future<void> setVisitorPastEvent(
    String UID,
    String TID,
    String EVID,
    String transferringTo,
    String transferringFrom,
  ) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(UID)
        .collection('curEvents')
        .doc(TID)
        .update({'EVID': EVID});
    ({'transferringTo': transferringTo});
    ({'transferringFrom': transferringFrom});
  }

  Future<void> setVisitorSentEvent(
    String UID,
    String TID,
    String EVID,
    String transferringTo,
    String transferringFrom,
  ) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(UID)
        .collection('curEvents')
        .doc(TID)
        .update({'EVID': EVID});
    ({'transferringTo': transferringTo});
    ({'transferringFrom': transferringFrom});
  }

  /*
  void setOwner(String owner){ownerID = owner;}
  void setEvent(String event){eventname = event;}
  void setValid(bool v){valid = v;}
  */

  //Getters
  String getOwner() {
    return ownerID;
  }

  String getEvent() {
    return eventname;
  }

  bool isValid() {
    return valid;
  }

  TicketInfo(this.ownerID, this.eventname, this.valid);
}

//Pass User's uid to get list of each Doc in that User's curEvents
Future<List<TicketInfo>> getUserCurEventList(String userID) async {
  List<TicketInfo> tlist = [];
  String tempowner;
  String tempevent;
  bool tempvalid;
  int iterate = 0;

  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userID)
      .collection('curEvents')
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      tempowner = result.data()['oname'].toString();
      tempevent = result.data()['ename'].toString();
      tempvalid = result.data()['isValid'].toString().toLowerCase() == 'true';
      tlist.add(TicketInfo(tempowner, tempevent, tempvalid));
      print('Function list during query is length ' + tlist.length.toString());
/*Test for tlist
      for (int i = 0; i < tlist.length; i++) {
        print(tlist[i].ownerID +
            ' ' +
            tlist[i].eventname +
            ' ' +
            tlist[i].valid.toString());
        print(i);
      }
      */

      //Tests

      //result.data().forEach((k, v) => print("got key $k with $v"));
      //print(result.data());
      //print(tempowner + ' ' + tempevent + ' ' + tempvalid.toString());
      //print(i);
      //i++;
    });
    print('Function list after adding is length ' + tlist.length.toString());
    for (int i = 0; i < tlist.length; i++) {
      print(tlist[i].ownerID +
          ' ' +
          tlist[i].eventname +
          ' ' +
          tlist[i].valid.toString());
      print(i);
    }
  });

//TicketInfo tempticket()
  print('Function list after query is length ' + tlist.length.toString());
  return tlist;
}

/*
firestoreInstance.collection("Users").get().then((querySnapshot) {
  querySnapshot.docs.forEach((result) {
    firestoreInstance
        .collection("Users")
        .doc(result.id)
        .collection("curEvents")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });
  });
});
}

for (int i = 0; i < tlist.length; i++) {
    print(tlist[i].ownerID +
        ' ' +
        tlist[i].eventname +
        ' ' +
        tlist[i].valid.toString());
    print(i);
  }

class TicketQuery {
  getUser() async {
    final _auth = FirebaseAuth.instance;
    final user1 = _auth.currentUser;
    final userid = user1?.uid;

    // print(userid);
    return userid.toString();
  }

  String owner = " ";
  String event = " ";
  bool isValid = false;
  bool isTransferring = false;

  List<Ticket>? _ticketList;

  
}
*/