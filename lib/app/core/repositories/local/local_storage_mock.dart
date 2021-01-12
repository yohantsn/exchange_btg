import 'package:app_btg/app/core/repositories/local/local_storage_interface.dart';

class LocalStorageMock implements ILocalStorage{
  Map<String, dynamic> _data = <String,dynamic>{};

  @override
  Future<void> delete({String key}) async{
    _data.remove(key);
  }

  @override
  Future<String> get({String key}) async {
    dynamic value = _data.containsKey(key);
    return Future.value(value);
  }

  @override
  Future<void> put({String key, String value}) async {
    _data[key] = value;
  }
  
}