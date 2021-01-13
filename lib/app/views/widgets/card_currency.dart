import 'package:app_btg/app/views/widgets/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'container_outline.dart';

Widget cardCurrency({String textId, String textName, BuildContext context, Function onPressed}){
  return GestureDetector(
    child: Container(
      alignment: Alignment.center,
      height:  90,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textOutline(
                  text: "$textId",
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width  * 0.20
              ),
              Expanded(
                  child: Text(
                    "$textName",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorsTheme.colorTextButton),
                  )),
            ],
          ),
          Divider(color: ColorsTheme.colorButtonBackground,)
        ],
      ),
    ),
    onTap: onPressed,
  );
}