import 'dart:convert';

import 'package:app_btg/app/core/const/api_const.dart';
import 'package:app_btg/app/core/models/currencies_model.dart';
import 'package:app_btg/app/core/models/quotes_model.dart';
import 'package:app_btg/app/core/repositories/api/exchange_interface.dart';
import 'package:app_btg/app/core/repositories/local/local_storage_interface.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';


class ExchangeApi implements IExchange{

  final ILocalStorage localStorage = Modular.get();
  Dio dio = Dio();

  @override
  Future<CurrenciesModel> getCurrencies() async{
    final urlCurrencies = "${ApiConst.urlCurrencies}${ApiConst.apiKey}";
    CurrenciesModel currenciesModel;
    try {
      Response response = await dio.get(urlCurrencies);
      if(response.data != null && response.data.toString().isNotEmpty){
        localStorage.put(key: "currencies", value: response.data);
        currenciesModel = CurrenciesModel.fromJson(jsonDecode(response.data));
      }
      print(response);
    } catch (e) {
      throw(e);
    }
    return currenciesModel;
  }

  @override
  Future<QuotesModel> getQuotes() async{
    final urlQuotes = "${ApiConst.urlQuotes}${ApiConst.apiKey}";
    QuotesModel quotesModel;
    try {
      Response response = await dio.get(urlQuotes);
      if(response.data != null && response.data.toString().isNotEmpty){
        localStorage.put(key: "quotes", value: response.data);
        quotesModel = QuotesModel.fromJson(jsonDecode(response.data));
      }
      print(response);
    } catch (e) {
      throw(e);
    }
    return quotesModel;
  }

}