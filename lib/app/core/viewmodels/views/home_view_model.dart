import 'dart:convert';

import 'package:app_btg/app/core/models/currencies_model.dart';
import 'package:app_btg/app/core/models/currency_selected_model.dart';
import 'package:app_btg/app/core/models/quotes_model.dart';
import 'package:app_btg/app/core/repositories/api/exchange_interface.dart';
import 'package:app_btg/app/core/repositories/local/local_storage_interface.dart';
import 'package:app_btg/app/core/tools/verify_internet_interface.dart';
import 'package:app_btg/app/core/viewmodels/base_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeViewModel extends BaseViewModel {
  final ILocalStorage localStorage = Modular.get();
  final IExchange exchange = Modular.get();
  final IVerifyInternet internet = Modular.get();

  QuotesModel quotesModel;
  CurrenciesModel currenciesModel;
  CurrencySelectedModel toCurrencySelectedModel;
  CurrencySelectedModel fromCurrencySelectedModel;

  bool isConnected = false;
  double resultCurrency = 0.0;

  HomeViewModel() {
    internet.isConnected().then((value) {
      this.isConnected = value;
      getCurrenciesModel();
      getQuotesModel();
      if (this.fromCurrencySelectedModel == null) {
        this.fromCurrencySelectedModel = CurrencySelectedModel(
            idCurrency: "BRL",
            quoteUSD: quotesModel.quotes
                .firstWhere((element) => element.idQuote == "USDBRL")
                .valueQuote,
            nameCurrency: currenciesModel.currencies
                .firstWhere((element) => element.idCurrency == "BRL")
                .nameCurrency);
      }
      if (this.toCurrencySelectedModel == null) {
        this.toCurrencySelectedModel = CurrencySelectedModel(
            idCurrency: "USD",
            quoteUSD: quotesModel.quotes
                .firstWhere((element) => element.idQuote == "USDUSD")
                .valueQuote,
            nameCurrency: currenciesModel.currencies
                .firstWhere((element) => element.idCurrency == "USD")
                .nameCurrency);
      }
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

  void calculate({@required double value}) {
    if (this.toCurrencySelectedModel.idCurrency == "USD" ||
        this.fromCurrencySelectedModel.idCurrency == "USD") {
      if (this.fromCurrencySelectedModel.idCurrency == "USD") {
        final result = value * this.toCurrencySelectedModel.quoteUSD;
        this.resultCurrency = result;
      } else {
        final result = value / this.toCurrencySelectedModel.quoteUSD;
        this.resultCurrency = result;
      }
    } else {
      final result = ((value / this.fromCurrencySelectedModel.quoteUSD) *
          this.toCurrencySelectedModel.quoteUSD);
      this.resultCurrency = result;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
