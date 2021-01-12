import 'dart:convert';

import 'package:app_btg/app/core/models/currencies_model.dart';
import 'package:app_btg/app/core/models/currency_selected_model.dart';
import 'package:app_btg/app/core/models/quotes_model.dart';
import 'package:app_btg/app/core/repositories/api/exchange_interface.dart';
import 'package:app_btg/app/core/repositories/local/local_storage_interface.dart';
import 'package:app_btg/app/core/tools/verify_internet_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../base_view_model.dart';

class SelectCurrencyViewModel extends BaseViewModel{
  final ILocalStorage localStorage = Modular.get();
  final IExchange exchange = Modular.get();
  final IVerifyInternet internet = Modular.get();

  QuotesModel quotesModel;
  CurrenciesModel currenciesModel;
  CurrencySelectedModel currencySelectedModel;

  bool isConnected = false;
  bool isLoading = false;

  SelectCurrencyViewModel(){
    this.isLoading = true;
    internet.isConnected().then((value) {
      this.isConnected = value;
      getQuotesModel();
      getCurrenciesModel();
      this.isLoading = false;
    });
  }

  Future<void> getQuotesModel() async {
    if (this.isConnected) {
      this.quotesModel = await exchange.getQuotes();
    } else {
      String jsonLocal = await localStorage.get(key: "quotes");
      this.quotesModel = QuotesModel.fromJson(jsonDecode(jsonLocal));
    }
  }

  Future<void> getCurrenciesModel() async {
    if (this.isConnected) {
      this.currenciesModel = await exchange.getCurrencies();
    } else {
      String jsonLocal = await localStorage.get(key: "currencies");
      this.currenciesModel = CurrenciesModel.fromJson(jsonDecode(jsonLocal));
    }
  }

  void selectCurrency({String idCurrency}){
    this.currencySelectedModel = CurrencySelectedModel(
        idCurrency: idCurrency,
        nameCurrency: currenciesModel.currencies
            .firstWhere((element) => element.idCurrency == idCurrency)
            .nameCurrency,
        quoteUSD: quotesModel.quotes
            .firstWhere((element) => element.idQuote.substring(0,3) == idCurrency)
            .valueQuote
    );
    Modular.to.pop(this.currencySelectedModel);
  }
}