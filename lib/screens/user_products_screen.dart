import 'package:flutter/material.dart';
import 'package:flutter_autos/provider/products.dart';
import 'package:flutter_autos/screens/edit_products_screen.dart';
import 'package:flutter_autos/widgets/app_drawer.dart';
import 'package:flutter_autos/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({super.key});

  static const routeName = 'user-products-screen';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Products'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductsScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, index) => Column(
                  children: [
                    UserProductItem(
                      productsData.items[index].id!,
                      productsData.items[index].title!,
                      productsData.items[index].imageURL101!,
                    ),
                    const Divider(
                      color: Colors.black,
                    )
                  ],
                )),
      ),
    );
  }
}
