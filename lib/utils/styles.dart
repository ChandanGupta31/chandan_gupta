import 'package:flutter/material.dart';

class Style{

  // Normal text Style
  static const normalTextStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.normal
  );

  static const headingText = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 22,
      fontWeight: FontWeight.normal
  );

  // Heading Text Style
  static const headerTextStyle = TextStyle(
    fontFamily: 'BlackOps',
    fontSize: 28,
    fontWeight: FontWeight.bold
  );

  // Sub Heading Text Style
  static const subHeaderTextStyle = TextStyle(
      fontFamily: 'BlackOps',
      fontSize: 22,
      fontWeight: FontWeight.bold
  );

  // Box Style
  static var boxStyle = BoxDecoration(
    // color: Color(0xFFC6EEF4),
    borderRadius:  BorderRadius.circular(10),
    border: Border.all(
      // color: Color(0xFF1CBDD2),
      width: 1,
    )
  );
}