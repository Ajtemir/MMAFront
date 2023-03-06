import 'package:flutter/material.dart';
import 'package:mma/common/app_colors.dart';
import 'package:mma/features/domain/entities/Common/product_entity.dart';

const link =
    'https://media.istockphoto.com/id/1187524818/photo/film-crew.jpg?s=612x612&w=0&k=20&c=lNyT4D0_6NTeXINFe-_tY7WEHkf0EwFuXOoiaoXaS6Q=';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cellBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 166,
            height: 166,
            child: Image.network(link), // todo set photo
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              Text(
                product.description ?? '',
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color:
                          (product.price == null) ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${product.price ?? 'Contract'}',
                    style: const TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Id продавца:',
                    style: TextStyle(
                      color: AppColors.greyColor,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    product.userId.toString(),
                    style: const TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
