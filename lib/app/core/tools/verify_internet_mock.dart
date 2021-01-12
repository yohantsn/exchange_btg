import 'package:app_btg/app/core/tools/verify_internet_interface.dart';

class VerifyInternetMock implements IVerifyInternet{
  @override
  Future<bool> isConnected() {
   return Future.value(true);
  }

}