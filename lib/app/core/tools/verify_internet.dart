import 'dart:io';

import 'package:app_btg/app/core/tools/verify_internet_interface.dart';

class VerifyInternet implements IVerifyInternet{

  @override
  Future<bool> isConnected() async{
    bool _isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isConnected = true;
      }
    } on SocketException catch (_) {
      _isConnected = false;
    }
    return _isConnected;
  }
}