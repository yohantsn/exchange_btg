import 'package:app_btg/app/views/widgets/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: ColorsTheme.colorBackground,
          backgroundColor: ColorsTheme.colorBackground,
          appBarTheme: AppBarTheme(backgroundColor: ColorsTheme.colorBackground),
        ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      navigatorKey: Modular.navigatorKey,
      onGenerateRoute: Modular.generateRoute,
    );
  }
}