import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bandedBoot_navigation/registration_navigation/signup_screen.dart';
import 'package:flutter_application_1/home_navigation/profile_navigation/eventCreation_screen.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketToBuild {
/*extends StatefulWidget {
 final EVName;
 final UName;
 final pic;
 final date;
 TicketToBuild(this.EVName, this.UName, this.pic, this.date);
 
 @override
 TicketToBuildState createState() =>
     TicketToBuildState(this.EVName, this.UName, this.pic, this.date);
}
 
class TicketToBuildState extends State<TicketToBuild> {
 String EVName;
 String UName;
 String pic;
 String date;
 
 TicketToBuildState(this.EVName, this.UName, this.pic, this.date);
 
 @override
 void initState() {
   super.initState();
 }
 
 @override*/
  Widget ticketBuilder(EVName, UName, pic, date) {
    return Container(
      height: 200,
      width: 800,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Stack(children: <Widget>[
        renderPic(pic, EVName),
        Positioned(
          bottom: 10,
          top: -110,
          left: 10,
          right: 10,
          child: Image.asset('assets/images/bandedNameLogo.png',
              scale: 9, alignment: Alignment.center),
        ),
        Positioned(
          bottom: 10,
          top: 85,
          left: 10,
          right: 10,
          child: Text(EVName,
              style: GoogleFonts.spartan(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: .5)),
              textAlign: TextAlign.center),
        ),
        Positioned(
          bottom: 10,
          top: 100,
          left: 10,
          right: 10,
          child: Text(date,
              style: GoogleFonts.spartan(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .5)),
              textAlign: TextAlign.center),
        ),
        Positioned(
          bottom: 10,
          top: 120,
          left: 10,
          right: 10,
          child: Image.asset('assets/images/qr.png',
              scale: 130, alignment: Alignment.center),
          // Text('$name',
          //     textAlign: TextAlign.center),
        ),
        Positioned(
          bottom: 10,
          top: 150,
          left: 0,
          right: 200,
          child: Text(UName,
              style: GoogleFonts.spartan(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 7,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .5)),
              textAlign: TextAlign.center),
          // Text('$name',
          //     textAlign: TextAlign.center),
        ),
      ]),
    );
  }

  Widget renderPic(String pic, String name) {
    // String pic1 = pic.replaceAll(",", "");
    // String picName = pic + '.png';
    if (pic == null) {
      return Card(child: Text(name, textAlign: TextAlign.center));
    } else
      return Image.network(pic,
          fit: BoxFit.fill,
          color: Color.fromRGBO(255, 255, 255, .86),
          colorBlendMode: BlendMode.modulate);
  }
}
