import 'package:flutter/material.dart';
import 'pages/pages.dart';
import 'package:tobuylist/shared/shared.dart';
import 'package:google_fonts/google_fonts.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentIconTheme: IconThemeData(size: 40),
        iconTheme: IconThemeData(size: 30, color: secondaryDark),
        // primaryColorDark: primaryDark,
        // primaryColor: primaryColor,
        // primaryColorLight: primaryLight,
        primaryTextTheme: GoogleFonts.lancelotTextTheme(TextTheme()),
        textTheme: GoogleFonts.titilliumWebTextTheme(),
        floatingActionButtonTheme: FloatingActionButtonThemeData(

          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: secondaryColor
        ),
        appBarTheme: AppBarTheme(
          textTheme: GoogleFonts.titilliumWebTextTheme(TextTheme(title: TextStyle(color: primaryText, fontSize: 30))),
          color: primaryColor
        ),
        primarySwatch: Colors.blue,
        
      ),
      home: App(),
    );
  }
}
