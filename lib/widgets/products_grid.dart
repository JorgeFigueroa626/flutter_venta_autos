import 'package:flutter/material.dart';
import 'package:flutter_autos/provider/products.dart';
import 'package:flutter_autos/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFaws;

  const ProductsGrid(this.showFaws, {super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFaws ? productsData.favoriteItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        //builder: (c) => products[index],
        //create: (BuildContext context) => products[index],
        value: products[index],
        child: const ProductItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //FORMA DE VER LOS AUTOS - LISTA  O CUADRADO
        crossAxisCount: 1,
        childAspectRatio: 16 / 9,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
