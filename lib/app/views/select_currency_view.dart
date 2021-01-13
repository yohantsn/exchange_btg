import 'package:app_btg/app/core/models/currencies_model.dart';
import 'package:app_btg/app/core/models/quotes_model.dart';
import 'package:app_btg/app/core/providers/view_model_provider.dart';
import 'package:app_btg/app/core/viewmodels/views/select_currency_view_model.dart';
import 'package:app_btg/app/views/widgets/card_currency.dart';
import 'package:app_btg/app/views/widgets/default_page.dart';
import 'package:app_btg/app/views/widgets/text_principal.dart';
import 'package:app_btg/app/views/widgets/text_quote_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectCurrencyView extends StatelessWidget {
  final CurrenciesModel currenciesModel;
  final QuotesModel quotesModel;
  SelectCurrencyView({this.quotesModel, this.currenciesModel});

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SelectCurrencyViewModel>(
        model: SelectCurrencyViewModel(
            currenciesModel: this.currenciesModel,
            quotesModel: this.quotesModel),
        builder: (SelectCurrencyViewModel model) {
          return model.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : defaultPage(
                  childWidget: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width,),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 10, 5),
                      child: textPrincipal(text: "Seleciona e moeda:"),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                      child: textQuoteField(
                        inputType: TextInputType.text,
                        labelText: "Pesquisar",
                        onChanged: (value) => model.searchCurrency(value: value),
                        inputFormatter: <TextInputFormatter>[]
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: model.currenciesModelOriginal.currencies.length,
                      itemBuilder: (context, index) {
                        return cardCurrency(
                            textId: model
                                .currenciesModelOriginal.currencies[index].idCurrency,
                            textName: model
                                .currenciesModelOriginal.currencies[index].nameCurrency,
                            context: context,
                            onPressed: () {
                              model.selectCurrency(
                                  idCurrency: model.currenciesModelOriginal
                                      .currencies[index].idCurrency);
                            });
                      },
                    ))
                  ],
                ));
        });
  }
}
