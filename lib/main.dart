import 'package:app_btg/app/app_module.dart';
import 'package:app_btg/app/core/viewmodels/views/home_view_model.dart';
import 'package:app_btg/app/views/widgets/color_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: ColorsTheme.colorBackground, // navigation bar color
    statusBarColor: ColorsTheme.colorBackground
  ));
  runApp( ChangeNotifierProvider(
        child: ModularApp(
          module: AppModule(),
        ),
        create: (_)=> HomeViewModel()),);
}