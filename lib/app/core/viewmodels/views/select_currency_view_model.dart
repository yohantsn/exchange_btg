
import 'package:app_btg/app/core/models/currencies_model.dart';
import 'package:app_btg/app/core/models/currency_selected_model.dart';
import 'package:app_btg/app/core/models/quotes_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../base_view_model.dart';

class SelectCurrencyViewModel extends BaseViewModel{

  QuotesModel quotesModel;
  CurrenciesModel currenciesModel;
  CurrenciesModel currenciesModelOriginal;
  CurrencySelectedModel currencySelectedModel;

  bool _isConnected = false;
  bool _isLoading = false;

  bool get isConnected => _isConnected;
  bool get isLoading => _isLoading;

  SelectCurrencyViewModel({this.currenciesModel, this.quotesModel}){
    this.currenciesModelOriginal = this.currenciesModel;
  }

  void selectCurrency({String idCurrency}){
    this.currencySelectedModel = CurrencySelectedModel(
        idCurrency: idCurrency,
        nameCurrency: currenciesModel.currencies
            .firstWhere((element) => element.idCurrency == idCurrency)
            .nameCurrency,
        quoteUSD: quotesModel.quotes
            .firstWhere((element) => element.idQuote.contains(idCurrency))
            .valueQuote
    );
    Modular.to.pop(this.currencySelectedModel);
  }

  void searchCurrency({String value}){
    CurrenciesModel _currenciesModel = CurrenciesModel(currencies: <Currency>[]);
    this.currenciesModelOriginal = this.currenciesModel;
    if(value.isNotEmpty){
      for(Currency item in this.currenciesModel.currencies){
        final id = item.idCurrency.toUpperCase();
        final name = item.nameCurrency.toUpperCase();
        if(id.contains(value.toUpperCase()) || name.contains(value.toUpperCase())){
          _currenciesModel.currencies.add(item);
        }
      }
        this.currenciesModelOriginal = _currenciesModel;
    }
    notifyListeners();
  }
}