import 'package:evently_app/core/resourse/ColorsManager.dart';
import 'package:flutter/material.dart';

class AppStyle{
  static ThemeData light=ThemeData(
    scaffoldBackgroundColor: ColorsManager.backgroundLight,
    colorScheme: ColorScheme.light(
    primary: ColorsManager.black,
    secondary: ColorsManager.blue,
      tertiary: ColorsManager.field,
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
    scaffoldBackgroundColor: ColorsManager.backgroundDark,
      colorScheme: ColorScheme.dark(
          primary: ColorsManager.text_dark,
          secondary: ColorsManager.blue,
           tertiary: ColorsManager.blue
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