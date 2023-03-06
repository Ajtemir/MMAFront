import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mma/features/presentation/bloc/search_bloc/search_event.dart';
import 'package:mma/features/presentation/bloc/search_bloc/search_state.dart';

import '../../../../core/error/failure.dart';
import '../../../domain/usecases/Common/search_products.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_ERROR = 'Cached Failure';
class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState>{
  final SearchProduct searchProduct;

  ProductSearchBloc({required this.searchProduct}) : super(ProductEmpty());

  Stream<ProductSearchState> mapEventToState(ProductSearchEvent event) async* {
    if(event is SearchProducts){
      yield* _mapFetchProductToState(event.productQuery);
    }
  }

  Stream<ProductSearchState> _mapFetchProductToState(String productQuery) async* {
    yield ProductSearchLoading();

    final failureOrPerson = await searchProduct(SearchProductParams(query: productQuery));

    yield failureOrPerson.fold(
            (failure) =>  ProductSearchError(message: _mapFailureToMessage(failure)),
            (products) => ProductSearchLoaded(products: products)
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