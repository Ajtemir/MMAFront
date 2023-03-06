import 'package:equatable/equatable.dart';

import '../../../domain/entities/Common/product_entity.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object> get props => [];
}

class ProductEmpty extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {
    final List<ProductEntity> oldProductList;
    final bool isFirstFetch;
  const ProductLoading(this.oldProductList, {this.isFirstFetch=false});
  @override
  List<Object> get props => [oldProductList];
}

class ProductLoaded extends ProductState {
  final List<ProductEntity> productList;
  const ProductLoaded(this.productList);
  @override
  List<Object> get props => [productList];
}

class ProductError extends ProductState {
  final String message;
  const ProductError({required this.message});
  @override
  List<Object> get props => [message];
}