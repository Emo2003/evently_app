import 'package:evently_app/core/resourse/ColorsManager.dart';
import 'package:flutter/material.dart';

class AppStyle{
  static ThemeData light=ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.blue,
      shape: StadiumBorder(
        side: BorderSide(
          color: Colors.white,
          width: 5
        )
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorsManager.blue,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
     selectedLabelStyle: TextStyle(
       fontSize: 14,
       fontWeight: FontWeight.w700
     ),
     unselectedLabelStyle: TextStyle(
         fontSize: 14,
         fontWeight: FontWeight.w700
     ),
      type: BottomNavigationBarType.fixed,
    )
,
    scaffoldBackgroundColor: ColorsManager.backgroundLight,
    colorScheme: ColorScheme.light(
    primary: ColorsManager.black,
    secondary: ColorsManager.blue,
      tertiary: ColorsManager.field,
        onSecondary: ColorsManager.field

    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: ColorsManager.blue,
        fontSize: 20,
        fontWeight: FontWeight.w700),
      titleMedium: TextStyle(
          color: ColorsManager.black,
          fontSize:16 ,
          fontWeight: FontWeight.w500
      ),
      titleSmall: TextStyle(
          color: ColorsManager.field,
          fontSize:16 ,
          fontWeight: FontWeight.w500
      ),
        headlineSmall: TextStyle(
            color: ColorsManager.blue,
            fontSize:16 ,
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.underline,
            decorationColor: ColorsManager.blue
        )
    )

  );

  static ThemeData dark = ThemeData(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorsManager.backgroundDark,
        shape: StadiumBorder(
            side: BorderSide(
                color: Colors.white,
                width: 5
            )
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorsManager.backgroundDark,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorsManager.text_dark,
        unselectedItemColor: ColorsManager.text_dark,

        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),

      scaffoldBackgroundColor: ColorsManager.backgroundDark,
      colorScheme: ColorScheme.dark(
          primary: ColorsManager.text_dark,
          secondary: ColorsManager.blue,
           tertiary: ColorsManager.blue,
        onSecondary: ColorsManager.text_dark
      ),
      textTheme: TextTheme(
          headlineLarge: TextStyle(
              color: ColorsManager.blue,
              fontSize: 20,
              fontWeight: FontWeight.w700),
          titleMedium: TextStyle(
              color: ColorsManager.backgroundLight,
              fontSize:16 ,
              fontWeight: FontWeight.w500
          ),
          titleSmall: TextStyle(
              color: ColorsManager.text_dark,
              fontSize:16 ,
              fontWeight: FontWeight.w500
          ),
        headlineSmall: TextStyle(
          color: ColorsManager.blue,
          fontSize:16 ,
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.underline,
            decorationColor: ColorsManager.blue
        )
      )

  );
}