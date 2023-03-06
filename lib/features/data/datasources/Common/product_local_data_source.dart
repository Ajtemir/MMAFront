import 'dart:convert';

import 'package:mma/core/error/Exception.dart';
import 'package:mma/features/data/models/Common/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
abstract class BaseProductLocalDataSource{
  Future<List<ProductModel>> getLastProductFromCache();
  Future<void> productToCache(List<ProductModel> products);
}

const CACHED_PRODUCTS_LIST = 'CACHED_PRODUCTS_LIST';
class ProductLocalDataSource implements BaseProductLocalDataSource{
  final SharedPreferences sharedPreferences;

  ProductLocalDataSource({required this.sharedPreferences});

  @override
  Future<List<ProductModel>> getLastProductFromCache() {
    final jsonProductsList = sharedPreferences.getStringList(CACHED_PRODUCTS_LIST);
    if(jsonProductsList?.isNotEmpty ?? false){
      return Future.value(jsonProductsList!.map((e) => ProductModel.fromJson(json.decode(e))).toList());
    } else{
      throw CacheException();
    }
  }

  @override
  Future<void> productToCache(List<ProductModel> products) {
    final List<String> jsonProductsList = products.map((product)=>json.encode(product.toJson())).toList();
    sharedPreferences.setStringList(CACHED_PRODUCTS_LIST, jsonProductsList);
    return Future.value();
  }
  
}