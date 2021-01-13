import 'package:app_btg/app/views/widgets/color_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textSecondary({@required text}) {
  return Text(
    "$text",
    textAlign: TextAlign.left,
    style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: ColorsTheme.colorText),
  );
}
