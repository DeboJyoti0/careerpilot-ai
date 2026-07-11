import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  textTheme: GoogleFonts.poppinsTextTheme(),
);