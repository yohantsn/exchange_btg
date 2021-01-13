import 'dart:convert';
import 'dart:io';

import 'package:app_btg/app/core/models/currencies_model.dart';
import 'package:app_btg/app/core/models/quotes_model.dart';
import 'package:app_btg/app/core/viewmodels/views/select_currency_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

import 'resources/navigation_mock.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  File fileQuotes = File("test/resources/quotes.json");
  File fileCurrencies = File("test/resources/currencies.json");
  String jsonQuotes = await fileQuotes.readAsString();
  String jsonCurrencies = await fileCurrencies.readAsString();
  Modular.navigatorDelegate = MyNavigatorMock();

  SelectCurrencyViewModel selectCurrencyViewModel = SelectCurrencyViewModel(
      currenciesModel:
          CurrenciesModel.fromJson(jsonDecode(jsonCurrencies),),
      quotesModel: 
          QuotesModel.fromJson(jsonDecode(jsonQuotes)));

  test("teste calculate", () {
    selectCurrencyViewModel.selectCurrency(idCurrency: "MXN");
    expect(selectCurrencyViewModel.currencySelectedModel.quoteUSD, 20.22588);
  });
}
