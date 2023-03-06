import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String? description;
  final Decimal? price;
  final int userId;

  const ProductEntity({
    required this.id,
    this.description,
    this.price,
    required this.userId,
  });

  @override
  List<Object?> get props => [id];
}
