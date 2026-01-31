import 'package:flutter/material.dart';
import 'package:mvvmclean/presentation/resources/color_manger.dart';
import 'package:mvvmclean/presentation/resources/font_manger.dart';
import 'package:mvvmclean/presentation/resources/styles_mangers.dart';
import 'package:mvvmclean/presentation/resources/value_manger.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main Colors
    primaryColor: ColorManger.primary,
    primaryColorLight: ColorManger.lightPrimary,
    primaryColorDark: ColorManger.darkPrimary,
    disabledColor: ColorManger.grey1,
    splashColor: ColorManger.lightPrimary, ////ripple efect color
    //card View theme
    cardTheme: CardThemeData(
      color: ColorManger.white,
      shadowColor: ColorManger.grey,
      elevation: AppSize.s4,
    ),

    //app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: AppSize.s4,
      shadowColor: ColorManger.lightPrimary,
      backgroundColor: ColorManger.primary,
      foregroundColor: ColorManger.white,
      titleTextStyle: getRegularStyle(
        color: ColorManger.white,
        fontSize: FontSize.s16,
      ),
    ),
    //button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManger.grey1,
      buttonColor: ColorManger.primary,
      splashColor: ColorManger.lightPrimary,
    ),
    // elevvated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManger.white,
          fontSize: FontSize.s17,
        ),
        backgroundColor: ColorManger.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ), // RoundeRectangle
      ),
    ),
    //text theme
    textTheme: TextTheme(
      displayLarge: getSemiboldStyle(
        color: ColorManger.darkGrey,
        fontSize: FontSize.s16,
      ),

      headlineLarge: getSemiboldStyle(
        color: ColorManger.darkGrey,
        fontSize: FontSize.s16,
      ),

      headlineMedium: getRegularStyle(
        color: ColorManger.darkGrey,
        fontSize: FontSize.s14,
      ),

      titleMedium: getMediumStyle(
        color: ColorManger.lightGrey,
        fontSize: FontSize.s14,
      ),
      bodySmall: getRegularStyle(color: ColorManger.grey),

      bodyLarge: getRegularStyle(color: ColorManger.grey1), //caption
    ),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      //content padding
      contentPadding: EdgeInsets.all(AppPadding.p8),
      //hiny Style
      hintStyle: getRegularStyle(
        color: ColorManger.grey,
        fontSize: FontSize.s14,
      ),
      //label Style
      labelStyle: getMediumStyle(
        color: ColorManger.grey,
        fontSize: FontSize.s14,
      ),
      //error Style
      errorStyle: getRegularStyle(color: ColorManger.error),
      //enable border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManger.grey, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      //focused border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManger.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      //error border
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManger.error, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      //focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManger.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),
  );
}
