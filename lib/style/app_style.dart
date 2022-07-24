import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle{
  //App Colors
  static Color mainColor =  const Color(0xFFE0E0E0);
  static Color accentColor =  const Color(0xFFFFC000);
  static Color bgColor =  const Color(0xFFe2e2ff);
  static Color textColor = const Color.fromARGB(255, 0, 0, 0);

  //Cards
  static List<Color> cardsColor = [
    Colors.teal.shade100,
    Colors.red.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.yellow.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.blueGrey.shade100,
    Colors.lightBlue.shade100,
  ];

  //text style
  static TextStyle mainTitle = 
    GoogleFonts.roboto(fontSize: 19.0, fontWeight: FontWeight.bold);

  static TextStyle mainContent = 
    GoogleFonts.nunito(fontSize: 16.0, fontWeight: FontWeight.normal);

  static TextStyle dateTitle = 
    GoogleFonts.roboto(fontSize: 13.0, fontWeight: FontWeight.w500);
}