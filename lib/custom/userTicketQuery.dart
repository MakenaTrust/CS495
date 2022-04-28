import 'package:cloud_firestore/cloud_firestore.dart';

//curEvent Updaters

Future<void> updateUserCurEventEVID(
    String userID, String ticketID, String newData) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userID)
      .collection('curEvents')
      .doc(ticketID)
      .update({'EVID': newData});
}

Future<void> updateUserCurEventTransferringFrom(
    String userID, String ticketID, String newData) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userID)
      .collection('curEvents')
      .doc(ticketID)
      .update({'transferringFrom': newData});
}

Future<void> updateUserCurEventTransferringTo(
    String userID, String ticketID, String newData) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userID)
      .collection('curEvents')
      .doc(ticketID)
      .update({'transferringTo': newData});
}

// recEvent Updaters
Future<void> updateUserRecEventEVID(
    String userID, String ticketID, String newData) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userID)
      .collection('recEvents')
      .doc(ticketID)
      .update({'EVID': newData});
}

Future<void> updateUserRecEventTransferringFrom(
    String userID, String ticketID, String newData) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userID)
      .collection('recEvents')
      .doc(ticketID)
      .update({'transferringFrom': newData});
}

Future<void> updateUserRecEventTransferringTo(
    String userID, String ticketID, String newData) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userID)
      .collection('recEvents')
      .doc(ticketID)
      .update({'transferringTo': newData});
}

//sentEvent Updaters

Future<void> updateUserSentEventEVID(
    String userID, String ticketID, String newData) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userID)
      .collection('sentEvents')
      .doc(ticketID)
      .update({'EVID': newData});
}

Future<void> updateUserSentEventTransferringFrom(
    String userID, String ticketID, String newData) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userID)
      .collection('sentEvents')
      .doc(ticketID)
      .update({'transferringFrom': newData});
}

Future<void> updateUserSentEventTransferringTo(
    String userID, String ticketID, String newData) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userID)
      .collection('sentEvents')
      .doc(ticketID)
      .update({'transferringTo': newData});
}

//pastEvents Updaters

Future<void> updateUserPastEventEVID(
    String userID, String ticketID, String newData) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userID)
      .collection('pastEvents')
      .doc(ticketID)
      .update({'EVID': newData});
}

Future<void> updateUserPastEventTransferringFrom(
    String userID, String ticketID, String newData) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userID)
      .collection('pastEvents')
      .doc(ticketID)
      .update({'transferringFrom': newData});
}

Future<void> updateUserPastEventTransferringTo(
    String userID, String ticketID, String newData) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userID)
      .collection('pastEvents')
      .doc(ticketID)
      .update({'transferringTo': newData});
}

//Generic User Ticket
class UserTicketQuery {
  String eventID = " ";
  String fromID = " ";
  String toID = " ";

  //curEvent Fetchers

  Future<String> fetchUserCurEventEVID(String userID, String ticketID) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .collection('curEvents')
        .doc(ticketID)
        .get()
        .then((ticket) {
      eventID = ticket.data()!['EVID'].toString();
    });
    return eventID;
  }

  Future<String> fetchUserCurEventWhoFrom(
      String userID, String ticketID) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .collection('curEvents')
        .doc(ticketID)
        .get()
        .then((ticket) {
      fromID = ticket.data()!['transferringFrom'].toString();
    });
    return fromID;
  }

  Future<String> fetchUserCurEventWhoTo(String userID, String ticketID) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .collection('curEvents')
        .doc(ticketID)
        .get()
        .then((ticket) {
      toID = ticket.data()!['transferringTo'].toString();
    });
    return toID;
  }

  // recEvent fetchers

  Future<String> fetchUserRecEventEVID(String userID, String ticketID) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .collection('recEvents')
        .doc(ticketID)
        .get()
        .then((ticket) {
      eventID = ticket.data()!['EVID'].toString();
    });
    return eventID;
  }

  Future<String> fetchUserRecEventWhoFrom(
      String userID, String ticketID) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .collection('recEvents')
        .doc(ticketID)
        .get()
        .then((ticket) {
      fromID = ticket.data()!['transferringFrom'].toString();
    });
    return fromID;
  }

  Future<String> fetchUserRecEventWhoTo(String userID, String ticketID) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .collection('recEvents')
        .doc(ticketID)
        .get()
        .then((ticket) {
      toID = ticket.data()!['transferringTo'].toString();
    });
    return toID;
  }

  //sentEvent fetchers

  Future<String> fetchUserSentEventEVID(String userID, String ticketID) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .collection('sentEvents')
        .doc(ticketID)
        .get()
        .then((ticket) {
      eventID = ticket.data()!['EVID'].toString();
    });
    return eventID;
  }

  Future<String> fetchUserSentEventWhoFrom(
      String userID, String ticketID) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .collection('sentEvents')
        .doc(ticketID)
        .get()
        .then((ticket) {
      fromID = ticket.data()!['transferringFrom'].toString();
    });
    return fromID;
  }

  Future<String> fetchUserSentEventWhoTo(String userID, String ticketID) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .collection('sentEvents')
        .doc(ticketID)
        .get()
        .then((ticket) {
      toID = ticket.data()!['transferringTo'].toString();
    });
    return toID;
  }

  //pastEvents fetchers

  Future<String> fetchUserPastEventEVID(String userID, String ticketID) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .collection('curEvents')
        .doc(ticketID)
        .get()
        .then((ticket) {
      eventID = ticket.data()!['EVID'].toString();
    });
    return eventID;
  }

  Future<String> fetchUserPastEventWhoFrom(
      String userID, String ticketID) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .collection('curEvents')
        .doc(ticketID)
        .get()
        .then((ticket) {
      fromID = ticket.data()!['transferringFrom'].toString();
    });
    return fromID;
  }

  Future<String> fetchUserPastEventWhoTo(String userID, String ticketID) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .collection('curEvents')
        .doc(ticketID)
        .get()
        .then((ticket) {
      toID = ticket.data()!['transferringTo'].toString();
    });
    return toID;
  }
}
