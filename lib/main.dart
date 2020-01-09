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

      debugShowCheckedModeBanner: false,
      title: 'ToBuyList',

      theme: ThemeData(
        
        cardTheme: CardTheme(
          elevation: 0
        ),
        primaryColor: primaryColor,
        accentColor: primaryColor,
        buttonColor: primaryColor,
        buttonTheme: ButtonThemeData(
          buttonColor: secondaryColor,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5), side: BorderSide(color: secondaryColor)),
          
        ),
        scaffoldBackgroundColor: Colors.white,
        
        accentIconTheme: IconThemeData(size: 40),
        iconTheme: IconThemeData(size: 30, color: secondaryDark),
        // primaryColorDark: primaryDark,
        // primaryColor: primaryColor,
        // primaryColorLight: primaryLight,
        primaryTextTheme: GoogleFonts.lancelotTextTheme(TextTheme()),
        textTheme: GoogleFonts.titilliumWebTextTheme(TextTheme(body1: TextStyle(fontSize: 15), button: TextStyle(fontSize: 15,color: primaryColor) , body2: TextStyle(fontSize: 18), )),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),

          backgroundColor: secondaryDark

        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            size: 30,
            color: Colors.white
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.white,
            size: 30
          ),
          textTheme: GoogleFonts.titilliumWebTextTheme(TextTheme(title: TextStyle(color: primaryText, fontSize: 30))),
          color: primaryColor

        ),
        primarySwatch: Colors.blue,
        
      ),
      home: App(),
    );
  }
}

