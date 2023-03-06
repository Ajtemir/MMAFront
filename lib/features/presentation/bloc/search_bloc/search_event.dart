import 'package:equatable/equatable.dart';

abstract class ProductSearchEvent extends Equatable{
  const ProductSearchEvent();
  @override
  List<Object?> get props => [];
}

class SearchProducts extends ProductSearchEvent {
  final String productQuery;
  const SearchProducts(this.productQuery);
}