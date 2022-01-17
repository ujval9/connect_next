import 'package:flutter/material.dart';

class Themes {
  ThemeData lightTheme() {
    return ThemeData(
      fontFamily: 'josefin',
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      primaryColor: Colors.yellow,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        elevation: 0.5,
        color: Colors.yellow,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      colorScheme: const ColorScheme.light(
          // secondary: Color(0xffE5F7DD),
          ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 5,
        color: Colors.white,
      ),
      // iconTheme: const IconThemeData(
      //   color: Colors.orange,
      // ),
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 20.0, color: Colors.black),
      ),
    );
  }
}
