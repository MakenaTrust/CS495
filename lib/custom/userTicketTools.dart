import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/custom/userTicketQuery.dart';
import '/custom/eventTicketQuery.dart';

//Current Tickets (Users/curEvents)

Future<void> addNewTicketToUserCurEvent(
    String userID, String ticketID, String eventID) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userID)
      .collection('curEvents')
      .doc(ticketID)
      .set({
    'EVID': eventID,
    'transferringTo': ' ',
    'transferringFrom': ' ',
  });
}

Future<void> addSentTicketToUserCurEvent(
    String toUserID, String fromUserID, String ticketID, String eventID) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(toUserID)
      .collection('curEvents')
      .doc(ticketID)
      .set({
    'EVID': eventID,
    'transferringTo': ' ',
    'transferringFrom': fromUserID,
  });
}

Future<void> removeTicketFromUserCurEvent(
    String userID, String ticketID) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userID)
      .collection('curEvents')
      .doc(ticketID)
      .delete();
}

//Recieving Tickets (Users/recEvents)

Future<void> addTicketToUserRecEvent(
    String toUserID, String fromUserID, String ticketID, String eventID) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(toUserID)
      .collection('recEvents')
      .doc(ticketID)
      .set({
    'EVID': eventID,
    'transferringTo': toUserID,
    'transferringFrom': fromUserID,
  });
}

Future<void> removeTicketFromUserRecEvent(
    String userID, String ticketID) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userID)
      .collection('recEvents')
      .doc(ticketID)
      .delete();
}

// Sent Tickets (Users/sentEvents)

Future<void> addTicketToUserSentEvent(
    String toUserID, String fromUserID, String ticketID, String eventID) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(fromUserID)
      .collection('sentEvents')
      .doc(ticketID)
      .set({
    'EVID': eventID,
    'transferringTo': toUserID,
    'transferringFrom': fromUserID,
  });
}

// Past Tickets (Users/pastEvents)

Future<void> addTicketToUserPastEvent(String userID, String ticketID,
    String eventID, String transFrom, String transTo) async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(userID)
      .collection('pastEvents')
      .doc(ticketID)
      .set({
    'EVID': eventID,
    'transferringTo': transTo,
    'transferringFrom': transFrom,
  });
}

// Ticket Movement/Ownership Tools

Future<void> claimUnownedTicket(
    String newOwnerID, String tid, String evid) async {
  await Future.wait([
    addNewTicketToUserCurEvent(newOwnerID, tid, evid),
    updateEventTicketOwner(evid, tid, newOwnerID),
  ]);
}

Future<void> transferTicket(
    String fromUser, String toUser, String tid, String evid) async {
  await Future.wait([
    // Needs to check that the ticket is in fromUser curEvents FIRST
// make sure they havent used it
    addSentTicketToUserCurEvent(toUser, fromUser, tid, evid),
    addTicketToUserSentEvent(toUser, fromUser, tid, evid),
    removeTicketFromUserRecEvent(toUser, tid),
    removeTicketFromUserCurEvent(fromUser, tid),
    updateEventTicketOwner(evid, tid, toUser),
  ]);
}

Future<void> sendTicket(
    String fromUser, String toUser, String tid, String evid) async {
  await Future.wait([
    addTicketToUserRecEvent(toUser, fromUser, tid, evid),
    updateUserCurEventTransferringTo(fromUser, tid, toUser),
  ]);
}

//Needs to make sure that the Owned Ticket (curEvent) has no transferringTo
Future<void> useOwnedTicket(String owner, String transFrom, String transTo,
    String tid, String evid) async {
  await Future.wait([
    addTicketToUserPastEvent(owner, tid, evid, transFrom, transTo),
    removeTicketFromUserCurEvent(owner, tid),
  ]);
}
