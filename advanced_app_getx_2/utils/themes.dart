import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AppColors.dart';

class AppThemes {
  AppThemes({required this.context}) {
    lightTheme = ThemeData.light().copyWith(
      colorScheme: ColorScheme.light(
        primary: AppColors.darkBlack,
        secondary: AppColors.darkBlack,
      ),
      primaryColor: AppColors.darkBlack,
      backgroundColor: AppColors.white,
      hintColor: AppColors.darkBlack.withOpacity(.7),
      textTheme: GoogleFonts.nunitoTextTheme(
        Theme.of(context).textTheme.copyWith(
              bodyText2: TextStyle(color: AppColors.darkBlack),
            ),
      ),
      primaryIconTheme: IconThemeData(
        color: AppColors.darkBlack,
      ),
      iconTheme: IconThemeData(
        color: AppColors.darkBlack,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.darkBlack,
        selectionColor: AppColors.darkBlack.withOpacity(.5),
        selectionHandleColor: AppColors.darkBlack,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      indicatorColor: AppColors.white,
    );
    darkTheme = ThemeData.light().copyWith(
      colorScheme: ColorScheme.light(
        primary: AppColors.darkBlack,
        secondary: AppColors.white,
      ),
      primaryColor: AppColors.white,
      backgroundColor: AppColors.darkBlack,
      hintColor: AppColors.white.withOpacity(.7),
      textTheme: GoogleFonts.nunitoTextTheme(
        Theme.of(context).textTheme.copyWith(
              bodyText2: TextStyle(color: AppColors.white),
            ),
      ),
      primaryIconTheme: IconThemeData(
        color: AppColors.white,
      ),
      iconTheme: IconThemeData(
        color: AppColors.white,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.white,
        selectionColor: AppColors.white.withOpacity(.5),
        selectionHandleColor: AppColors.white,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      indicatorColor: AppColors.darkBlack,
    );
  }

  late BuildContext context;

  late ThemeData lightTheme;
  late ThemeData darkTheme;
}
