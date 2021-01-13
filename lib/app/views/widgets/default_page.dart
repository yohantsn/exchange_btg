import 'package:app_btg/app/views/widgets/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget defaultPage({Widget childWidget}) {
  return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsTheme.colorBackground,
    body: childWidget,
  ));
}
