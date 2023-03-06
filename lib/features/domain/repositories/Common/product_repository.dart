import 'package:dartz/dartz.dart';
import '../../entities/Common/product_entity.dart';
import '../../../../core/error/failure.dart';

abstract class BaseProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts(int page);
  Future<Either<Failure, List<ProductEntity>>> searchProduct(String query);
}