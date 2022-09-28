import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seaweed/theme/app_colors.dart';

extension text on String {
  appTextOpenSans(
      {double size = 20,
      FontWeight fontWeight = FontWeight.w800,
      Color color = appWhite}) {
    return Text(
      this,
      style: GoogleFonts.openSans(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }

  appTextSifonn(
      {double size = 20,
      FontWeight fontWeight = FontWeight.w800,
      Color color = Colors.black}) {
    return Text(
      this,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontFamily: "SIFONN",
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }

  showSnackBar() {
    return Get.showSnackbar(GetBar(
      message: this,
    ));
  }

  isValidEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}

appTextStyleSifonFont(
    {required Color color,
    required double fontSize,
    required FontWeight fontWeight}) {
  return TextStyle(
    overflow: TextOverflow.ellipsis,
    color: color,
    fontSize: fontSize,
    fontFamily: "Sifonn",
    fontWeight: fontWeight,
  );
}

appTextStyleOpenSensFont(
    {required Color color,
    required double fontSize,
    required FontWeight fontWeight}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: "Open Sans",
    fontWeight: fontWeight,
  );
}

showAppSnackBar(String tittle) {
  return Get.showSnackbar(GetBar(
    message: tittle,
    duration: const Duration(seconds: 3),
  ));
}

extension Size on double {
  addHSpace() {
    return SizedBox(
      height: this,
    );
  }

  addWSpace() {
    return SizedBox(
      width: this,
    );
  }
}
