import 'package:flutter/material.dart';
import 'package:flutter_autos/provider/auth.dart';
import 'package:flutter_autos/screens/edit_products_screen.dart';
import 'package:flutter_autos/screens/home_screen.dart';
import 'package:flutter_autos/screens/nosotros_screen.dart';
import 'package:flutter_autos/screens/product_detail_screen.dart';
import 'package:flutter_autos/screens/product_overview_screen.dart';
import 'package:flutter_autos/provider/products.dart';
import 'package:flutter_autos/screens/splash_screen.dart';
import 'package:flutter_autos/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: (_) => Products('', '', []),
            update: (context, auth, previousProducts) => Products(
                auth.token as String,
                auth.userId as String,
                previousProducts == null ? [] : previousProducts.items))
      ],
      //child: ChangeNotifierProvider.value(
      //builder: (context) => Products(),
      //create: (BuildContext context) => Products(),
      //value: Products(),
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CarShop',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          //PANTALLA DE INICIO
          home: auth.isAuth
              ? const ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResultsnapshot) =>
                      authResultsnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : HomeScreen(),
                ),
          //LLAMAMOS LA RUTAS DE LAS PANTALLAS
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            ProductsOverviewScreen.routeName: (context) =>
                const ProductsOverviewScreen(),
            ProductDeatilScreen.routeName: (context) =>
                const ProductDeatilScreen(),
            NosotrosScreen.routeName: (context) => const NosotrosScreen(),
            UserProductsScreen.routeName: (context) =>
                const UserProductsScreen(),
            EditProductsScreen.routeName: (context) =>
                const EditProductsScreen(),
          },
        ),
      ),
    );
  }
}
