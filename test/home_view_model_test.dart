import 'dart:convert';
import 'dart:io';

import 'package:app_btg/app/app_module.dart';
import 'package:app_btg/app/core/models/currency_selected_model.dart';
import 'package:app_btg/app/core/repositories/api/exchange_interface.dart';
import 'package:app_btg/app/core/repositories/api/exchange_mock.dart';
import 'package:app_btg/app/core/repositories/local/local_storage_interface.dart';
import 'package:app_btg/app/core/repositories/local/local_storage_mock.dart';
import 'package:app_btg/app/core/tools/verify_internet_interface.dart';
import 'package:app_btg/app/core/tools/verify_internet_mock.dart';
import 'package:app_btg/app/core/viewmodels/views/home_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';


void main() async{
  TestWidgetsFlutterBinding.ensureInitialized();
  File fileQuotes =  File("test/resources/quotes.json");
  File fileCurrencies =  File("test/resources/currencies.json");
  Map<String, dynamic> _mapJson = <String,dynamic>{};
  String jsonQuotes = await fileQuotes.readAsString();
  _mapJson["quotes"] = jsonQuotes;
  String jsonCurrencies = await fileCurrencies.readAsString();
  _mapJson["currencies"] = jsonCurrencies;
  initModule(AppModule(),
      changeBinds: [
        Bind<ILocalStorage>((i)=> LocalStorageMock()),
        Bind<IExchange>((i)=> ExchangeMock(json: jsonEncode(_mapJson))),
        Bind<IVerifyInternet>((i)=> VerifyInternetMock())
      ]);
  
  HomeViewModel homeViewModel = HomeViewModel();
  test("teste calculate", (){
    homeViewModel.toCurrencySelectedModel 
    = CurrencySelectedModel(quoteUSD: 5.49, idCurrency: "BRL", nameCurrency: "Real");
    homeViewModel.fromCurrencySelectedModel
    = CurrencySelectedModel(quoteUSD: 20.22, idCurrency: "MXN", nameCurrency: "Peso");
    
    homeViewModel.calculate(value: 500);
    expect(homeViewModel.resultCurrency.toStringAsFixed(2), "135.76");
  });
}