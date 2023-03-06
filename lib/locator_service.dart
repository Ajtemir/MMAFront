import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mma/core/platform/network_info.dart';
import 'package:mma/features/data/datasources/Common/product_local_data_source.dart';
import 'package:mma/features/data/datasources/Common/product_remote_data_source.dart';
import 'package:mma/features/data/repositories/product_repository.dart';
import 'package:mma/features/domain/repositories/Common/product_repository.dart';
import 'package:mma/features/domain/usecases/Common/get_all_products.dart';
import 'package:mma/features/presentation/bloc/product_list_cubit/product_list_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:mma/features/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/domain/usecases/Common/search_products.dart';
final sl = GetIt.instance;
// Call Flow
Future<void> init() async {
  // BLoC / Cubit
  sl.registerFactory(() => ProductListCubit(getAllProducts: sl()));
  sl.registerFactory(() => ProductSearchBloc(searchProduct: sl()));
  // UseCases
  sl.registerLazySingleton(() => GetAllProducts(sl()));
  sl.registerLazySingleton(() => SearchProduct(sl()));
  // Repository
  sl.registerLazySingleton<BaseProductRepository>(
    () => ProductRepository(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl()
    )
  );
  // data source
  sl.registerLazySingleton<BaseProductRemoteDataSource>(() =>
      ProductRemoteDataSource(
          client: sl()
      )
  );
  sl.registerLazySingleton<BaseProductLocalDataSource>(() =>
      ProductLocalDataSource(sharedPreferences: sl())
  );

  // Core
  sl.registerLazySingleton(() => NetworkInfo(
      // connectionChecker = null
  ));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => InternetConnectionChecker());
}