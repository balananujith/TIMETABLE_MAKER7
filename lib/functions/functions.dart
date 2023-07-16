import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
      textStyle:const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold)
  );
}

TextStyle get headingStyle{
  return GoogleFonts.lato(
      textStyle:const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold)
  );
}

TextStyle get titleStyle{
  return GoogleFonts.lato(
      textStyle:const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold)
  );
}

TextStyle get subtitleStyle{
  return GoogleFonts.lato(
      textStyle:const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold)
  );
}
