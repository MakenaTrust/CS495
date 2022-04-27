import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addBlankTicketToEvent(String eventID) async {
  await FirebaseFirestore.instance
      .collection('Events')
      .doc(eventID)
      .collection('Tickets')
      .add({
    'ownerID': ' ',
    'purchasetime': ' ',
    'lastreserved': ' ',
  });
}

Future<void> updateEventTicketOwner(
    String eventID, String ticketID, String newOwnerID) async {
  await FirebaseFirestore.instance
      .collection('Events')
      .doc(eventID)
      .collection('Tickets')
      .doc(ticketID)
      .update({'ownerID': newOwnerID});
}

Future<void> updateEventTicketReservetime(
    String eventID, String ticketID, DateTime newTimestamp) async {
  await FirebaseFirestore.instance
      .collection('Events')
      .doc(eventID)
      .collection('Tickets')
      .doc(ticketID)
      .update({'ownerID': newTimestamp.toIso8601String()});
}

class EventTicketQuery {
  String owner = " ";
  String timebought = " ";
  String timereserved = " ";

  //Fetchers

  Future<String> fetchEventTicketOwnerID(
      String eventID, String ticketID) async {
    await FirebaseFirestore.instance
        .collection('Events')
        .doc(eventID)
        .collection('Tickets')
        .doc(ticketID)
        .get()
        .then((ticket) {
      owner = ticket.data()!['ownerID'].toString();
    });
    return owner;
  }

  Future<String> fetchEventTicketReservetime(
      String eventID, String ticketID) async {
    await FirebaseFirestore.instance
        .collection('Events')
        .doc(eventID)
        .collection('Tickets')
        .doc(ticketID)
        .get()
        .then((ticket) {
      timereserved = ticket.data()!['lastreserved'].toString();
    });
    return timereserved;
  }

  Future<String> fetchEventTicketPurchaseTime(
      String eventID, String ticketID) async {
    await FirebaseFirestore.instance
        .collection('Events')
        .doc(eventID)
        .collection('Tickets')
        .doc(ticketID)
        .get()
        .then((ticket) {
      timebought = ticket.data()!['purchasetime'].toString();
    });
    return timebought;
  }
}
