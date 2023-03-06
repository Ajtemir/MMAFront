import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mma/features/domain/entities/Common/product_entity.dart';
import 'package:mma/features/presentation/bloc/product_list_cubit/product_list_state.dart';
import '../../../../core/error/failure.dart';
import '../../../domain/usecases/Common/get_all_products.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_ERROR = 'Cached Failure';
class ProductListCubit extends Cubit<ProductState>{
  final GetAllProducts getAllProducts;
  ProductListCubit({required this.getAllProducts}) : super(ProductEmpty());
  int page = 1;
  void loadPerson() async {
    if(state is ProductLoading) return;
    final currentState = state;
    var oldProduct = <ProductEntity>[];
    if(currentState is ProductLoaded) {
      oldProduct = currentState.productList;
    }
    emit(ProductLoading(oldProduct, isFirstFetch: page == 1));
    final failureOrProduct = await getAllProducts(PageProductParams(page));
    failureOrProduct.fold(
        (error) => ProductError(message: _mapFailureToMessage(error)),
        (product){
          page++;
          final products = (state as ProductLoading).oldProductList;
          products.addAll(product);
          emit(ProductLoaded(products));
        }
    );
  }

  String _mapFailureToMessage(Failure failure){
    switch (failure.runtimeType){
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_ERROR;
      default:
        return 'Unexpected Error';
    }
  }
}