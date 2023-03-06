import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mma/features/domain/entities/Common/product_entity.dart';
import 'package:mma/features/presentation/bloc/product_list_cubit/product_list_cubit.dart';
import 'package:mma/features/presentation/bloc/product_list_cubit/product_list_state.dart';
import 'package:mma/features/presentation/widgets/product_card_widget.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListCubit, ProductState>(
      builder: (context, state) {
        List<ProductEntity> products = [];
        bool isLoading = false;
        if(state is ProductLoading && state.isFirstFetch)
        {
          return _loadingIndicator();
        }
        else if (state is ProductLoaded)
        {
          products = state.productList;
        }
        else if(state is ProductLoading)
        {
          products = state.oldProductList;
          isLoading = true;
        }
        else if (state is ProductError)
        {
          return Text(
            state.message,
            style: const TextStyle(color: Colors.white, fontSize: 25),
          );
        }
        return ListView.separated(
            itemBuilder: (context, index) {
              return ProductCard(product : products[index]);
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey[400],
              );
            },
            itemCount: products.length,
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
