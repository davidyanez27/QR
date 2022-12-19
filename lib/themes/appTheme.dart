import 'package:flutter/material.dart';


class AppTheme{
  
  static const Color primary = Colors.indigo;
  
  static final ThemeData lightTheme = ThemeData.light().copyWith(

    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0
    ),

    // inputDecorationTheme: InputDecorationTheme(
    //   floatingLabelStyle: const TextStyle(color: primary),
    //   enabledBorder: OutlineInputBorder(
    //     borderSide: const BorderSide(color: primary),
    //     borderRadius: BorderRadius.circular(20)
    //   ),

    // focusedBorder: OutlineInputBorder(
    //   borderSide: const BorderSide(color: primary),
    //   borderRadius: BorderRadius.circular(20)
    //   ),

    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))

    // ),


    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary, 
        shape: const StadiumBorder(),
        elevation: 0,
        textStyle: const TextStyle(fontSize: 20)
      )
    ),

  




  ); //Aqui termina el Light Theme

}//Aqui termina la clase