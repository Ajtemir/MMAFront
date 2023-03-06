import 'package:equatable/equatable.dart';

import '../../../domain/entities/Common/product_entity.dart';

abstract class ProductSearchState extends Equatable{
  const ProductSearchState();
  @override
  List<Object?> get props => [];
}

class ProductEmpty extends ProductSearchState {}

class ProductSearchLoading extends ProductSearchState{}

class ProductSearchLoaded extends ProductSearchState {
  final List<ProductEntity> products;
  const ProductSearchLoaded({required this.products});
  @override
  List<Object?> get props => [products];
}

class ProductSearchError extends ProductSearchState {
  final String message;
  const ProductSearchError({required this.message});
  @override
  List<Object> get props => [message];
}