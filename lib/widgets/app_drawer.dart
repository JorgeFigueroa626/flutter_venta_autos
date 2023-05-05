import 'package:flutter/material.dart';
import 'package:flutter_autos/provider/auth.dart';
import 'package:flutter_autos/screens/nosotros_screen.dart';
import 'package:flutter_autos/screens/product_overview_screen.dart';
import 'package:flutter_autos/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

//PLANTILLA DEL PERFIL
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.red,
        child: Column(
          children: <Widget>[
            AppBar(
              title: const Text('Drawer'),
              automaticallyImplyLeading: false,
            ),
            //SALTOS DEL PERFIL
            const Divider(),
            Container(
              color: Colors.red[600],
              child: ListTile(
                leading: const Icon(
                  Icons.shop,
                  color: Colors.white,
                ),
                title: const Text(
                  'Autos',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(ProductsOverviewScreen.routeName);
                },
              ),
            ),
            const Divider(),
            Container(
              color: Colors.red[600],
              child: ListTile(
                leading: const Icon(
                  Icons.perm_identity,
                  color: Colors.white,
                ),
                title: const Text(
                  'Perfl',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(NosotrosScreen.routeName);
                },
              ),
            ),
            const Divider(),
            Container(
              color: Colors.red[600],
              child: ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Provider.of<Auth>(context, listen: false).logout();
                },
              ),
            ),
            //DESAHABILITAR PARA LOS USUARIOS CLIENTES Y SOLO HABILITAR PARA EL ADMINISTRADOR
            const Divider(),
            Container(
              color: Colors.red[600],
              child: ListTile(
                leading: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                title: const Text(
                  'Products Manager',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(UserProductsScreen.routeName);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
