import 'package:flutter/foundation.dart';

abstract class ILocalStorage{
  Future<String> get({@required String key});
  Future put({@required String key, @required String value});
  Future delete({String key});
}