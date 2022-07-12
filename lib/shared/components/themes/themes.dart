import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_todo_app/shared/components/constants.dart';
import 'package:simple_todo_app/shared/cubit/cubit.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    backgroundColor: Colors.black,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 25.0,
    ),
    actionsIconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    headline6: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 23.0,
    ),
    headline5: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple,
    ),
    caption: TextStyle(
      color: Colors.white,
      fontSize: 15.0,
    ),
    bodyText1: TextStyle(color: Colors.white),
  ),
  iconTheme: const IconThemeData(
    color: Colors.deepPurple,
  ),
  primaryIconTheme: const IconThemeData(color: Colors.white),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.white,
    backgroundColor: Colors.deepPurple,
  ),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.pink,
  scaffoldBackgroundColor: Colors.amber.shade200,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backgroundColor: Colors.amber.shade200,
    elevation: 0.0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.amber,
    ),
    titleTextStyle: const TextStyle(
      color: Colors.pink,
      fontSize: 25.0,
    ),
    actionsIconTheme: const IconThemeData(color: Colors.pink),
  ),
  textTheme: const TextTheme(
    headline6: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.amber,
      fontSize: 23.0,
    ),
    headline5: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.pink,
    ),
    caption: const TextStyle(
      color: Colors.amber,
      fontSize: 15.0,
    ),
    bodyText1: TextStyle(
      color: Colors.pink,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.pink,
  ),
  primaryIconTheme: const IconThemeData(color: Colors.pink),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.amber.shade200,
    unselectedItemColor: Colors.white,
    backgroundColor: Colors.pink,
  ),
);
