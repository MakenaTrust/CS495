import 'package:cloud_firestore/cloud_firestore.dart';

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
