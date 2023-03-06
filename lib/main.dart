
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mma/common/app_colors.dart';
import 'package:mma/features/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:mma/locator_service.dart';

import 'features/presentation/bloc/product_list_cubit/product_list_cubit.dart';
import 'features/presentation/pages/product_screen.dart';
import 'locator_service.dart' as di;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ProductListCubit>(
              create : (context) => sl<ProductListCubit>()..loadPerson(),
          ),
          BlocProvider<ProductSearchBloc>(
              create: (context) => sl<ProductSearchBloc>()
          ),
        ],
        child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          backgroundColor: AppColors.mainBackground,
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        home: const HomePage(),
       ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   Future<List<ProductEntity>> getProducts() async {
//     final url = Uri.parse('http://localhost/products');
//     var httpResponse = await http.get(url);
//
//     if(httpResponse.statusCode != 200) throw Exception("Получена ошибка во время запроса");
//     final body = json.decode(httpResponse.body) as List;
//     var list = body.map((e) => ProductModel.fromJson(e)).toList();
//     return list;
//   }
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   late Future<List<ProductEntity>> _products;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _products = getProducts();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//
//         title: Text(widget.title),
//       ),
//       body: FutureBuilder<List<ProductEntity>>(
//         future: _products,
//         builder: (context, snapshot){
//           if(snapshot.hasData) {
//             return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index){
//                   return Card(
//                     child: ListTile(
//                       title: Text('${snapshot.data![index].description}'),
//                     ),
//                   );
//                 },
//             );
//           } else if(snapshot.hasError){
//             return  Text(snapshot.error.toString());
//           }
//           return Center(child: Text(snapshot.hasData.toString()));
//         },
//       ),
//
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
