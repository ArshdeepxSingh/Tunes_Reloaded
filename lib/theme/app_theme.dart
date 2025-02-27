import 'package:flutter/material.dart';
import 'package:tunes_reloaded/theme/app_colors.dart';


class AppTheme {

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'LeagueSpartan',
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.light,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(
        color: AppColors.grey
      ),
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: EdgeInsets.all(30),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.black, width: 1),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold  ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        )
        
        ))
  );


  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'LeagueSpartan',
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.dark,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(
        color: AppColors.grey
      ),
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(30),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white, width: 1),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(

        foregroundColor: Colors.white,
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        )
        
        ))
  );

}