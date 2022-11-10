import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final darkTheme = ThemeData(

  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey.shade900,
  iconTheme: IconThemeData(color: Colors.white),

  textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.white)
  ),

  appBarTheme: AppBarTheme(
    iconTheme:IconThemeData(color:Colors.white),
    backgroundColor: Colors.grey.shade900,
  ),



  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(),
    unselectedLabelStyle: TextStyle(),
    selectedItemColor: Colors.green,
    unselectedItemColor: Colors.white,
  ),

);

final ligtTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.blue),
  textTheme: TextTheme(
      bodyText2: TextStyle(color:Colors.black)
  ),

  appBarTheme: AppBarTheme(
    iconTheme:IconThemeData(color:Colors.black),
    backgroundColor: Colors.white,
    //   color: Global.defaultColor,
    foregroundColor: Colors.black,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle:TextStyle(),
    unselectedLabelStyle: TextStyle(),
    selectedItemColor: Colors.green,
    unselectedItemColor: Colors.black,
  ),
);
