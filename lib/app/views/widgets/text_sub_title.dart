import 'package:app_btg/app/views/widgets/color_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textSubTitle({@required text}) {
  return Text(
    "$text",
    textAlign: TextAlign.center,
    style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: ColorsTheme.colorTextButton),
  );
}
