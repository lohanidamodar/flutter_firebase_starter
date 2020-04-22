import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebasestarter/core/presentation/res/colors.dart';
import 'package:firebasestarter/core/presentation/res/sizes.dart';

class AppThemes {
  static BuildContext context;
  static final ThemeData defaultTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    accentColor: AppColors.accentColor,
    primarySwatch: Colors.red,
    buttonColor: AppColors.primaryColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
  );
}