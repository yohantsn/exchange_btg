import 'dart:convert';
import 'package:app_btg/app/core/models/currencies_model.dart';
import 'package:app_btg/app/core/models/currency_selected_model.dart';
import 'package:app_btg/app/core/models/quotes_model.dart';
import 'package:app_btg/app/core/repositories/api/exchange_interface.dart';
import 'package:app_btg/app/core/repositories/local/local_storage_interface.dart';
import 'package:app_btg/app/core/tools/verify_internet_interface.dart';
import 'package:app_btg/app/core/viewmodels/base_view_model.dart';
import 'package:flutter/cupertino.dart';
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

  bool _isConnected = false;
  bool _isLoading = true;
  double _resultCurrency = 0.0;
  String _errorText = "";
  double _valueToExchange = 0.0;

  bool get isLoading => _isLoading;
  double get resultCurrency => _resultCurrency;
  String get errorText => _errorText;

  HomeViewModel({BuildContext context}) {
    internet.isConnected().then((value) {
      this._isConnected = value;
      this._isLoading = true;
      getCurrenciesModel().then((_) {
        getQuotesModel().then((_) {
          if(this.currenciesModel != null && this.quotesModel != null){
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
          }
          if(this.quotesModel == null || this.currenciesModel == null){
            this._errorText = "Não foi possível receber os dados necessários, por favor, verifique sua conexão.";
          }
          this._isLoading = false;
          notifyListeners();
        });
      });
    });
  }

  Future<void> getQuotesModel() async {
    if (this._isConnected) {
      this.quotesModel = await exchange.getQuotes();
    }
    if (this.quotesModel == null || !this.quotesModel.success) {
      String jsonLocal = await localStorage.get(key: "quotes");
      if(jsonLocal != null &&jsonLocal.isNotEmpty) {
        this.quotesModel = QuotesModel.fromJson(jsonDecode(jsonLocal));
      }
    }
    notifyListeners();
  }

  Future<void> getCurrenciesModel() async {
    if (this._isConnected) {
      this.currenciesModel = await exchange.getCurrencies();
    }
    if (this.currenciesModel == null || !this.currenciesModel.success) {
      String jsonLocal = await localStorage.get(key: "currencies");
      if(jsonLocal != null && jsonLocal.isNotEmpty) {
        this.currenciesModel = CurrenciesModel.fromJson(jsonDecode(jsonLocal));
      }
    }
    notifyListeners();
  }

  void calculate({@required String value}) {
    try {
      double _value = double.parse(value);
      if (this.toCurrencySelectedModel.idCurrency == "USD" ||
          this.fromCurrencySelectedModel.idCurrency == "USD") {
        if (this.fromCurrencySelectedModel.idCurrency == "USD") {
          final result = _value * this.toCurrencySelectedModel.quoteUSD;
          this._resultCurrency = result;
        } else {
          final result = _value / this.fromCurrencySelectedModel.quoteUSD;
          this._resultCurrency = result;
        }
      } else {
        final result = ((_value / this.fromCurrencySelectedModel.quoteUSD) *
            this.toCurrencySelectedModel.quoteUSD);
        this._resultCurrency = result;
      }
      _valueToExchange = _value;
    } catch (e) {

    }
    notifyListeners();
  }

  Future<void> goToSelectCurrencies({bool isFromCurrency}) async {
    var _selectCurrency = await Modular.to
        .pushNamed("/currencies", arguments: {
      "quotesModel": this.quotesModel,
      "currenciesModel": this.currenciesModel
    });
    if(_selectCurrency != null){
      if(isFromCurrency){
        this.fromCurrencySelectedModel = _selectCurrency;
      }else{
        this.toCurrencySelectedModel = _selectCurrency;
      }
      calculate(value: _valueToExchange.toString());
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
