import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mma/features/domain/entities/Common/product_entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/Common/product_repository.dart';

class GetAllProducts extends UseCase<List<ProductEntity>, PageProductParams>{
  final BaseProductRepository productRepository;
  GetAllProducts(this.productRepository);
  @override
  Future<Either<Failure, List<ProductEntity>>> call(PageProductParams params) async
  {
    return await productRepository.getAllProducts(params.page);
  }
}

class PageProductParams extends Equatable {
  final int page;

  const PageProductParams(this.page);

  @override
  List<Object?> get props => [page];
}
