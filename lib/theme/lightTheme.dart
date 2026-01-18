import 'package:flutter/material.dart';


  ThemeData lightTheme =  ThemeData(
    iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStateProperty.all<Color>(Colors.black87),
    ),
  ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.black87,
      ),
      textTheme: const TextTheme(titleMedium: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
          titleLarge:
          TextStyle(
            color: Colors.black87,
            fontSize: 20,
          ),
          titleSmall: TextStyle(
            color: Colors.black87,
            fontSize: 14,
          )
      )
  );

