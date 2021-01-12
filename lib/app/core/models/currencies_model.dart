class CurrenciesModel {
  bool success;
  String terms;
  String privacy;
  String source;
  List<Currency> currencies = <Currency>[];

  CurrenciesModel(
      {this.success,
        this.terms,
        this.privacy,
        this.source,
        this.currencies});

  CurrenciesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    terms = json['terms'];
    privacy = json['privacy'];
    source = json['source'];
    Map<String, dynamic> mapQuotes = json['currencies'];
    mapQuotes.forEach((key, value) {
      Currency _currency = Currency(idCurrency: key, nameCurrency: value);
      currencies.add(_currency);
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['terms'] = this.terms;
    data['privacy'] = this.privacy;
    data['source'] = this.source;
    if (this.currencies != null) {
      data['currencies'] = this.currencies;
    }
    return data;
  }
}

class Currency {
  String idCurrency;
  String nameCurrency;

  Currency({
    this.idCurrency,
    this.nameCurrency
  });

  Currency.fromJson(Map<String, dynamic> json){
    idCurrency = json.keys.first;
    nameCurrency = json.values.first;
  }
}