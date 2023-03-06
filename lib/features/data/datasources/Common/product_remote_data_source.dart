import 'dart:convert';

import 'package:mma/core/error/Exception.dart';
import 'package:mma/features/data/models/Common/product_model.dart';
import 'package:http/http.dart' as http;

import '../../../../common/constant/url.dart';
abstract class BaseProductRemoteDataSource{
  Future<List<ProductModel>> getAllProducts(int page);
  Future<List<ProductModel>> searchProduct(String query);
}

class ProductRemoteDataSource implements BaseProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSource({required this.client});

  @override
  Future<List<ProductModel>> getAllProducts(int page) async {
    final url = Uri(
      scheme: Config.scheme,
      host: Config.host,
      port: Config.port,
      path: 'products'
    );
    final response = await client.get(url);
    if(response.statusCode == 200){
      final products = json.decode(response.body);
      final jsonList = products as List;
      final list = jsonList.map((product) => ProductModel.fromJson(product)).toList();
      return list;
    }else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> searchProduct(String query) => _getProductFromUrl(
      'https://rickandmortyapi.com/api/character/?name=$query'); // todo set url

  Future<List<ProductModel>> _getProductFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List)
          .map((person) => ProductModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }
}