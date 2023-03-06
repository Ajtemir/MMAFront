import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/Common/product_entity.dart';
import '../../repositories/Common/product_repository.dart';

class SearchProduct extends UseCase<List<ProductEntity>, SearchProductParams> {
  final BaseProductRepository productRepository;
  SearchProduct(this.productRepository);
  @override
  Future<Either<Failure, List<ProductEntity>>> call(SearchProductParams params) async
  {
    return await productRepository.searchProduct(params.query);
  }
}

class SearchProductParams extends Equatable {
  final String query;

  const SearchProductParams({required this.query});

  @override
  List<Object?> get props => [query];

}

