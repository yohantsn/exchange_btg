import 'package:app_btg/app/views/widgets/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';



Widget textQuoteField(
    {
    String labelText,
    TextInputType inputType,
    Function onChanged,
    String errorText,
    List<TextInputFormatter> inputFormatter}) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
    child: TextField(
      style: TextStyle(
          color: ColorsTheme.colorText
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: ColorsTheme.colorText, fontSize: 14),
        errorText: errorText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorsTheme.colorText),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorsTheme.colorText),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorsTheme.colorText),
        ),
      ),
      onChanged: onChanged,
      keyboardType: inputType,
      inputFormatters: inputFormatter,
    ));
}
