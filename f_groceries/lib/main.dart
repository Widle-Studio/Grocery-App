import 'package:f_groceries/Utils/constants.dart';
import 'package:f_groceries/screens/HomeScreen.dart';
import 'package:f_groceries/screens/splash_scree.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {



  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

     SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
      brightness: Brightness.light,
      backgroundColor: Constants.bG,
      primaryColor: Constants.primary,
      accentColor: Constants.accent,
      appBarTheme: AppBarTheme(
        color: Constants.bG,
        iconTheme: IconThemeData(
          color: Constants.primary,
        ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
          fontFamily: "openSans",
          )
      ),
      
      textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
          fontFamily: "openSans"
          )),
      home: SplashScreen(),
//      home: Walkthrough(),
    );
  }

}
