
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/product_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.white,
          ),
        ],
      ),
      body: const ProductList(),
    );
  }
}
