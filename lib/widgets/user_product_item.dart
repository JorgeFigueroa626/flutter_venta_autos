// ignore_for_file: sized_box_for_whitespace, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_autos/provider/products.dart';
import 'package:flutter_autos/screens/edit_products_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl101;

  const UserProductItem(this.id, this.title, this.imageUrl101, {super.key});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl101),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductsScreen.routeName, arguments: id);
              },
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProducts(id);
                } catch (e) {
                  const scaffold = SnackBar(
                    content:
                        Text('Borrado fallido', textAlign: TextAlign.center),
                  );
                }
              },
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
