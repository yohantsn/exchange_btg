import 'dart:convert';
import 'package:app_btg/app/core/models/currencies_model.dart';
import 'package:app_btg/app/core/models/quotes_model.dart';
import 'package:app_btg/app/core/viewmodels/views/select_currency_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

import 'resources/navigation_mock.dart';
import 'utils.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  String jsonQuotes =  fixture("quotes.json");
  String jsonCurrencies = fixture("currencies.json");
  Modular.navigatorDelegate = MyNavigatorMock();

  SelectCurrencyViewModel selectCurrencyViewModel = SelectCurrencyViewModel(
      currenciesModel:
          CurrenciesModel.fromJson(jsonDecode(jsonCurrencies),),
      quotesModel: 
          QuotesModel.fromJson(jsonDecode(jsonQuotes)));

  test("test select the currency", () {
    selectCurrencyViewModel.selectCurrency(idCurrency: "MXN");
    expect(selectCurrencyViewModel.currencySelectedModel.quoteUSD, 20.22588);
  });

  test("test search the currency", () {
    selectCurrencyViewModel.searchCurrency(value: "usd");
    expect(selectCurrencyViewModel.currenciesModelOriginal.currencies.length, 1);
  });
}
