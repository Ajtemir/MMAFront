import 'package:http/http.dart' as http;

import 'common/constant/url.dart';

void main() async{
  final url = Uri(
      scheme: Config.scheme,
      host: Config.host,
      port: Config.port,
      path: 'products'
  );
  print(url.toString());
  var httpResponse = await http.get(url);
  print(httpResponse.body);
}