// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_autos/provider/auth.dart';
import 'package:flutter_autos/provider/product.dart';
import 'package:flutter_autos/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      //FORMA DEL DISEÑO PANEL DEL PRODUCTO
      borderRadius: BorderRadius.circular(10),
      //BARRA DE DESCRIPCION
      child: GridTile(
        footer: Container(
          height: 55,
          //MOSTRAR FAVORITO
          child: GridTileBar(
            backgroundColor: Colors.black54,
            leading: Consumer<Product>(
              builder: (context, product, _) => IconButton(
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  product.toggleFavoriteStaus(authData.token!,authData.userId!);
                },
              ),
            ),
            //MOSTRAR TITULO
            title: Text(
              product.title!,
              style: const TextStyle(fontSize: 15),
              softWrap: true,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            ),
            trailing: Row(
              children: <Widget>[
                const Icon(Icons.attach_money),
                Text(
                  product.price!,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        //MOSTRAR IMAGEN
        //FUNCION DE ONCLIC A LA IMAGEN
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDeatilScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageURL101!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
