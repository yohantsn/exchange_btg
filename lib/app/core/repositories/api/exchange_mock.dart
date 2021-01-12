import 'dart:convert';

import 'package:app_btg/app/core/models/currencies_model.dart';
import 'package:app_btg/app/core/models/quotes_model.dart';
import 'package:app_btg/app/core/repositories/api/exchange_interface.dart';

class ExchangeMock implements IExchange{
  final String json;

  ExchangeMock({this.json});

  @override
  Future<CurrenciesModel> getCurrencies() {
    final jsonCurrencies = jsonDecode(json)["currencies"];
    CurrenciesModel currenciesModel = CurrenciesModel.fromJson(jsonDecode(jsonCurrencies));
    return Future.value(currenciesModel);
  }

  @override
  Future<QuotesModel> getQuotes() {
    final jsonQuotes = jsonDecode(json)["quotes"];
    QuotesModel quotesModel = QuotesModel.fromJson(jsonDecode(jsonQuotes));
    return Future.value(quotesModel);
  }

}