import 'package:decimal/decimal.dart';
import 'package:mma/features/domain/entities/Common/product_entity.dart';

class ProductModel extends ProductEntity{
  const ProductModel({
    required super.id,
    super.description,
    super.price,
    required super.userId,
  });

  factory ProductModel.fromJson(Map<String,dynamic> json){
    return ProductModel(
        id: json['id'] as int,
        description: json['description'] as String?,
        price: Decimal.parse(json['price'].toString()),
        userId: json['userId'] as int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description' : description,
      'price': price,
      'userId': userId
    };
  }
}