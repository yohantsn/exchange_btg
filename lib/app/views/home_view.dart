import 'package:app_btg/app/core/providers/view_model_provider.dart';
import 'package:app_btg/app/core/viewmodels/views/home_view_model.dart';
import 'package:app_btg/app/views/widgets/button_currency.dart';
import 'package:app_btg/app/views/widgets/default_page.dart';
import 'package:app_btg/app/views/widgets/text_principal.dart';
import 'package:app_btg/app/views/widgets/text_quote_field.dart';
import 'package:app_btg/app/views/widgets/text_secondary.dart';
import 'package:app_btg/app/views/widgets/text_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>(
        model: HomeViewModel(context: context),
        builder: (HomeViewModel model) {
          return defaultPage(
              childWidget: model.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : model.errorText.isNotEmpty
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: textSubTitle(text: model.errorText),
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: ListView(
                              padding: EdgeInsets.only(top: 40, bottom: 10),
                              //physics: NeverScrollableScrollPhysics(),
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 10, 10, 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      textPrincipal(text: "Conversão")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 5, 10, 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      textSecondary(
                                          text:
                                              "Clique no botão para alterar a moeda")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: textSubTitle(text: "De"),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 15),
                                    child: buttonCurrency(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        text: model.fromCurrencySelectedModel !=
                                                null
                                            ? model.fromCurrencySelectedModel
                                                .idCurrency
                                            : "",
                                        onPressed: () async {
                                          await model.goToSelectCurrencies(
                                              isFromCurrency: true);
                                        }),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/down_arrow.png",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                        ),
                                        Image.asset(
                                          "assets/images/up_arrow.png",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: textSubTitle(text: "Para"),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 15),
                                    child: buttonCurrency(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        text: model.toCurrencySelectedModel !=
                                                null
                                            ? model.toCurrencySelectedModel
                                                .idCurrency
                                            : "",
                                        onPressed: () async {
                                          await model.goToSelectCurrencies(
                                              isFromCurrency: false);
                                        }),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: textQuoteField(
                                        labelText:
                                            "Digite o valor a ser convertido",
                                        onChanged: (value) =>
                                            model.calculate(value: value),
                                        inputType:
                                            TextInputType.numberWithOptions(
                                                decimal: true, signed: false),
                                        inputFormatter: <TextInputFormatter>[
                                          FilteringTextInputFormatter.deny(
                                              RegExp("[( ) - ,]"))
                                        ],
                                      )),
                                ),
                                Center(
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 40, 10),
                                      child: textPrincipal(
                                          text:
                                              "${model.toCurrencySelectedModel != null ? model.toCurrencySelectedModel.idCurrency : ""} "
                                              "${model.resultCurrency.toStringAsFixed(2)}")),
                                )
                              ],
                            ))
                          ],
                        ));
        });
  }
}
