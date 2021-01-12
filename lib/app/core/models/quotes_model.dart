class QuotesModel {
  bool success;
  String terms;
  String privacy;
  int timestamp;
  String source;
  List<Quote> quotes = <Quote>[];

  QuotesModel(
      {this.success,
        this.terms,
        this.privacy,
        this.timestamp,
        this.source,
        this.quotes});

  QuotesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    terms = json['terms'];
    privacy = json['privacy'];
    timestamp = json['timestamp'];
    source = json['source'];
    Map<String, dynamic> mapQuotes = json['quotes'];
    mapQuotes.forEach((key, value) {
      double _value = value is int ? value.roundToDouble() : value;
      Quote _quote = Quote(idQuote: key, valueQuote: _value);
      quotes.add(_quote);
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['terms'] = this.terms;
    data['privacy'] = this.privacy;
    data['timestamp'] = this.timestamp;
    data['source'] = this.source;
    if (this.quotes != null) {
      data['quotes'] = this.quotes;
    }
    return data;
  }
}

class Quote {
  String idQuote;
  double valueQuote;

  Quote({
    this.idQuote,
    this.valueQuote
  });

  Quote.fromJson(Map<String, dynamic> json){
    idQuote = json.keys.first;
    valueQuote = json.values.first;
  }
}