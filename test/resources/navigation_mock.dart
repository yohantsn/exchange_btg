import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MyNavigatorMock implements IModularNavigator{
  @override
  bool canPop() {
    // TODO: implement canPop
    throw UnimplementedError();
  }

  @override
  Future<bool> maybePop<T extends Object>([T result]) {
    // TODO: implement maybePop
    throw UnimplementedError();
  }

  @override
  // TODO: implement modulePath
  String get modulePath => throw UnimplementedError();

  @override
  // TODO: implement navigator
  NavigatorState get navigator => throw UnimplementedError();

  @override
  // TODO: implement path
  String get path => throw UnimplementedError();

  @override
  void pop<T extends Object>([T result]) {
    ///
  }

  @override
  Future<T> popAndPushNamed<T extends Object, TO extends Object>(String routeName, {TO result, Object arguments}) {
    // TODO: implement popAndPushNamed
    throw UnimplementedError();
  }

  @override
  void popUntil(bool Function(Route p1) predicate) {
    // TODO: implement popUntil
  }

  @override
  Future<T> push<T extends Object>(Route<T> route) {
    // TODO: implement push
    throw UnimplementedError();
  }

  @override
  Future<T> pushNamed<T extends Object>(String routeName, {Object arguments}) {
    return null;
  }

  @override
  Future<T> pushNamedAndRemoveUntil<T extends Object>(String newRouteName, bool Function(Route p1) predicate, {Object arguments}) {
    // TODO: implement pushNamedAndRemoveUntil
    return null;
  }

  @override
  Future<T> pushReplacement<T extends Object, TO extends Object>(Route<T> newRoute, {TO result}) {
    // TODO: implement pushReplacement
    throw UnimplementedError();
  }

  @override
  Future<T> pushReplacementNamed<T extends Object, TO extends Object>(String routeName, {TO result, Object arguments}) {
    // TODO: implement pushReplacementNamed
    return null;
  }

  @override
  Future showDialog({Widget child, builder, bool barrierDismissible = true}) {
    // TODO: implement showDialog
    throw UnimplementedError();
  }

}