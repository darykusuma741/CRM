import 'package:flutter/material.dart';
import 'package:crm/common/constants/colors_name.dart';

class CustomLinearGradient {
  static LinearGradient blueCyanGradient = LinearGradient(
    colors: [
      ColorsName.blueLight,
      ColorsName.blueMedium,
      ColorsName.cyan,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient darkToBrightBlueGradient = LinearGradient(
    begin: Alignment.topCenter, // Arah gradien (kiri atas)
    end: Alignment(.5, 1.0), // Arah gradien (kanan bawah)
    // begin: Alignment(0.0, 0),
    // end: Alignment(0.0, 160.0),
    colors: [
      ColorsName.navyDark,
      ColorsName.blueDark,
    ],
    stops: [0.14051, 1.09013], // Persentase posisi warna (14.51% dan 109.13%)
    // transform: GradientRotation(57.76 * (3.141592653589793 / 180)), // Sudut gradien (157.76 derajat)
  );

  static LinearGradient redGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorsName.redLight,
      ColorsName.redMedium,
      ColorsName.redDark,
    ],
    stops: [0.0287, 0.4969, 1.0991],
  );
}
