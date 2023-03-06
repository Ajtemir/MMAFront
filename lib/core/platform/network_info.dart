import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
abstract class BaseNetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfo implements BaseNetworkInfo{
  // final InternetConnectionChecker connectionChecker;

  // NetworkInfo({required this.connectionChecker});
  @override
  // Future<bool> get isConnected => connectionChecker.hasConnection;
  Future<bool> get isConnected => Future.value(true);


}