import 'package:flutter/material.dart';
import 'package:schat2/eventStore.dart';

ThemeData darkTheme = ThemeData(
  
  appBarTheme: AppBarThemeData(backgroundColor: config.accentColor),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStateProperty.all<Color>(Colors.white70),
    ),
  ),
  iconTheme: IconThemeData(color: Colors.white70),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white70, // Цвет иконки в FAB
    backgroundColor: Colors.black54, // Фон кнопки
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      color: Colors.white70,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: Colors.white70,
      fontSize: 20,
    ),
    titleSmall: TextStyle(
      color: Colors.white70,
      fontSize: 14,
    ),

  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black38,
    selectedIconTheme: IconThemeData(color: Colors.white70), 
    unselectedIconTheme: IconThemeData(color: Colors.white70),
   
  selectedLabelStyle: TextStyle(color: Colors.white70, decorationColor: Colors.white70), 
  unselectedLabelStyle: TextStyle(color: Colors.white70, decorationColor: Colors.white70), 
  ), 
  scaffoldBackgroundColor: Colors.black45,
  elevatedButtonTheme: ElevatedButtonThemeData(style: 
  ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(179, 250, 245, 245)), 
    foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
    textStyle: WidgetStatePropertyAll(TextStyle(
      fontSize: 20,
    ))))
);



 
// final darkTheme = ThemeData.dark().copyWith(
//   // Базовая настройка тёмной темы
//   brightness: Brightness.dark,
//   canvasColor: Colors.black87,
//   primaryColorDark: Colors.indigo,

//   // Глобальная настройка цвета иконок
//   iconTheme: IconThemeData(color: Colors.white),

//   // Настройки FAB
//   floatingActionButtonTheme: FloatingActionButtonThemeData(
//     foregroundColor: Colors.white, // Цвет иконки в FAB
//     backgroundColor: Colors.black54, // Фон кнопки
//   ),

//   // Стилизация текста
//   textTheme: TextTheme(
//     titleMedium: TextStyle(
//       color: Colors.white,
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//     ),
//     titleLarge: TextStyle(
//       color: Colors.white,
//       fontSize: 20,
//     ),
//     titleSmall: TextStyle(
//       color: Colors.white,
//       fontSize: 14,
//     ),
//   ),
// );