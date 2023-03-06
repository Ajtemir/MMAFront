import 'package:dartz/dartz.dart';

import 'package:mma/core/error/failure.dart';
import 'package:mma/features/data/datasources/Common/product_local_data_source.dart';
import 'package:mma/features/data/datasources/Common/product_remote_data_source.dart';

import 'package:mma/features/domain/entities/Common/product_entity.dart';

import '../../../core/error/Exception.dart';
import '../../../core/platform/network_info.dart';
import '../../domain/repositories/Common/product_repository.dart';
import '../models/Common/product_model.dart';

class ProductRepository implements BaseProductRepository{
  final BaseProductRemoteDataSource remoteDataSource;
  final BaseProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo
  });
  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts(page);
        localDataSource.productToCache(remoteProducts);
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDataSource.getLastProductFromCache();
        return Right(localPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProduct(String query) async {
    return await _getProducts(() {
      return remoteDataSource.searchProduct(query);
    });
  }

  Future<Either<Failure, List<ProductModel>>> _getProducts(
      Future<List<ProductModel>> Function() getProducts) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await getProducts();
        localDataSource.productToCache(remoteProduct);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProduct = await localDataSource.getLastProductFromCache();
        return Right(localProduct);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}