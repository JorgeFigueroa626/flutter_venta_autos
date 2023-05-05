// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_autos/provider/products.dart';
import 'package:flutter_autos/widgets/app_drawer.dart';
import 'package:flutter_autos/widgets/products_grid.dart';
import 'package:provider/provider.dart';

//Metodo de Favoritos
enum FilterOption {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  static const routeName = 'product-overview-screen';

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos Overview'),
        //OPCION DE MOSTRAR FAVORITOS
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOption selectValue) {
              setState(() {
                if (selectValue == FilterOption.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: FilterOption.Favorites,
                child: Text('Solo Favoritos'),
              ),
              PopupMenuItem(
                value: FilterOption.All,
                child: Text('Mostrar Todos'),
              ),
            ],
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
