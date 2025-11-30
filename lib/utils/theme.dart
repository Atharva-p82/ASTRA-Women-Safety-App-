import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// LIGHT THEME: Vibrant, Friendly, Elegant
final safeHerThemeLight = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  primarySwatch: Colors.pink,
  scaffoldBackgroundColor: Color(0xFFFFF5FA), // Soft gradient base color
  primaryColor: Color(0xFFE94057), // Vibrant hot pink (top gradient)
  cardColor: Color(0xFFFCE4EC), // Soft blush
  textTheme: GoogleFonts.montserratTextTheme().apply(
    bodyColor: Color(0xFF303054),
    displayColor: Color(0xFFE94057),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF8BBD0), // Blush gradient
    elevation: 2,
    iconTheme: IconThemeData(color: Color(0xFFE94057)),
    titleTextStyle: GoogleFonts.montserrat(
      color: Color(0xFFE94057),
      fontWeight: FontWeight.w800,
      fontSize: 22,
    ),
    toolbarHeight: 66,
  ),
  cardTheme: CardThemeData(
    color: Color(0xFFFFFFFF),
    shadowColor: Color(0xFFE94057).withOpacity(0.09),
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFE94057),
      foregroundColor: Colors.white,
      shadowColor: Color(0xFFF8BBD0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 10,
      textStyle: GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFFFF1F7),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Color(0xFFE94057)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Color(0xFFF8BBD0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Color(0xFFE94057), width: 2),
    ),
    labelStyle: GoogleFonts.montserrat(
      color: Color(0xFFE94057),
      fontWeight: FontWeight.w600,
    ),
  ),
);
final safeHerThemeDark = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: kDarkDeepBlue,
  primaryColor: kDarkViolet,
  cardColor: kDarkCardBG,
  textTheme: GoogleFonts.montserratTextTheme().apply(
    bodyColor: Colors.white,         // <-- this applies to text you type!
    displayColor: kDarkViolet,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF232144),
    iconTheme: IconThemeData(color: kDarkViolet),
    titleTextStyle: GoogleFonts.montserrat(
      color: kDarkViolet,
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
    toolbarHeight: 66,
  ),
  cardTheme: CardThemeData(
    color: kDarkCardBG,
    shadowColor: kDarkViolet.withOpacity(0.14),
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kDarkViolet,
      foregroundColor: Colors.white,
      shadowColor: kDarkBlush,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 12,
      textStyle: GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF282A39),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: kDarkViolet),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Color(0xFF444444)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Color(0xFFFF0099), width: 2),
    ),
    labelStyle: GoogleFonts.montserrat(
      color: Color(0xFFFF0099),
      fontWeight: FontWeight.w600,
    ),
    hintStyle: TextStyle(
      color: Colors.white70, // <-- Ensures hint text is light too
      fontWeight: FontWeight.w400,
    ),
  ),
);

const kDarkBlush = Color(0xFFF8BBD0);
const kDarkCardBG = Color(0xFF232144);
const kDarkDeepBlue = Color(0xFF181A2A);
const kDarkPurple200 = Color(0xFFB39DDB);
const kDarkViolet = Color(0xFF8F5FE8);