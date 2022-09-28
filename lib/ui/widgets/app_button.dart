import 'package:flutter/material.dart';
import 'package:seaweed/theme/app_colors.dart';
import 'package:seaweed/utils/extension.dart';

class AppButton extends StatelessWidget {
  AppButton(
      {Key? key,
      this.color,
      required this.text,
      required this.onTap,
      this.textColor,
      this.height})
      : super(key: key);
  String text;
  VoidCallback onTap;
  Color? color;
  double? height;
  Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        height: height ?? 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color ?? appColor, borderRadius: BorderRadius.circular(70)),
        child: text.appTextSifonn(size: 20, color: textColor ?? Colors.black),
      ),
    );
  }
}
