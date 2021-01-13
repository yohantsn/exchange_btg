import 'package:app_btg/app/views/widgets/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget buttonCalculate(
    {@required String text,
    @required Function onPressed,
    @required double width,
    @required double height}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: ColorsTheme.colorButtonBackground,
          borderRadius: BorderRadius.circular(25)),
      child: Text(
        "$text",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorsTheme.colorTextButton),
      ),
    ),
  );
}
