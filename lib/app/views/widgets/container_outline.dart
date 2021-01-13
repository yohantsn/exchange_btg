import 'package:flutter/cupertino.dart';

import 'color_theme.dart';

Widget textOutline({String text, double height, double width}){
  return Container(
    alignment: Alignment.center,
    height: height,
    width: width,
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: ColorsTheme.colorBackground,
        border: Border.all(color: ColorsTheme.colorButtonBackground),
        borderRadius: BorderRadius.circular(10)),
    child: Text(
      "$text",
      style: TextStyle(
        color: ColorsTheme.colorText,
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
      textAlign: TextAlign.center,
    ),
  );
}