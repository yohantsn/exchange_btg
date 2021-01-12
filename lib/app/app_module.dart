import 'package:app_btg/app/core/repositories/api/exchange_api.dart';
import 'package:app_btg/app/core/repositories/api/exchange_interface.dart';
import 'package:app_btg/app/core/repositories/local/local_storage_interface.dart';
import 'package:app_btg/app/core/repositories/local/local_storage_shared.dart';
import 'package:app_btg/app/core/tools/verify_internet.dart';
import 'package:app_btg/app/core/tools/verify_internet_interface.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app_widget.dart';

class AppModule extends MainModule {

  @override
  List<Bind> get binds => [
    Bind<ILocalStorage>((i) => LocalStorageShared()),
    Bind<IExchange>((i) => ExchangeApi()),
    Bind<IVerifyInternet>((i) => VerifyInternet()),
  ];

  @override
  List<ModularRouter> get routers => [

  ];

  @override
  Widget get bootstrap => AppWidget();
}