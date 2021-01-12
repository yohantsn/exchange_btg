import 'package:app_btg/app/core/models/currencies_model.dart';
import 'package:app_btg/app/core/models/quotes_model.dart';

abstract class IExchange{
  Future<QuotesModel> getQuotes();
  Future<CurrenciesModel> getCurrencies();
}