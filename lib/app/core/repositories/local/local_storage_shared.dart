import 'dart:async';

import 'package:app_btg/app/core/repositories/local/local_storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageShared implements ILocalStorage{
  Completer<SharedPreferences> _instance = Completer<SharedPreferences>();

  _init() async{
    _instance.complete(await SharedPreferences.getInstance());
  }

  LocalStorageShared(){
    _init();
  }

  @override
  Future<void> delete({String key}) async {
    var shared = await _instance.future;
    shared.remove(key);
  }

  @override
  Future<String> get({String key}) async {
    var shared = await _instance.future;
    return shared.getString(key);
  }

  @override
  Future<void> put({String key, String value}) async{
    var shared = await _instance.future;
    shared.setString(key, value);
  }

}