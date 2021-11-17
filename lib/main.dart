
import 'package:estacionamento/ui/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp( GetMaterialApp(
    home: HomePage(),
    theme: ThemeData(
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.blue[800]
    ),
    primaryColor: Colors.blue[800],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.blue[800]
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.blue[800]
      )
    ),


    appBarTheme: AppBarTheme(color: Colors.blue[800])
  ),
  ));
}


