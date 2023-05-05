// ignore_for_file: unused_local_variable, sized_box_for_whitespace, import_of_legacy_library_into_null_safe, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, unused_import
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_autos/provider/products.dart';
import 'package:provider/provider.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProductDeatilScreen extends StatelessWidget {
  const ProductDeatilScreen({super.key});

  static const routeName = 'product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);

    //FORMATO DE LAS IMAGEN DEL DETALLE
    Widget imageCarousel = Container(
      height: 300,
      width: double.infinity,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          Image.network(loadedProduct.imageURL101!),
          Image.network(loadedProduct.imageURL102!),
          Image.network(loadedProduct.imageURL103!),
        ],
        autoplay: false,
        animationCurve: Curves.fastOutSlowIn,
        dotSize: 4.0,
        dotColor: Colors.red,
        indicatorBgPadding: 4.0,
      ),
    );

    //MOTODO DEL CONTACTO POR WHATSAPP
    void whatsAppOpen() async {
      await FlutterLaunch.launchWhatsapp(
          phone: loadedProduct.whatsapp.toString(),
          message: "Que tal me interesa el automovil ${loadedProduct.title}");
    }

    //MOTODO DEL LLAMADO POR TELEFONO
    Future<void> _launchCaller(String number) async {
      var url = "tel: ${number.toString()}";
     try {
        if (await canLaunchUrlString(url)) await launchUrlString(url);
      } catch (e) {
        rethrow;
      }

     /* if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'No se pudo realizar la llamada';
      }*/

      /*Uri url = Uri(scheme: "tel", path: phoneNumber);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          print("Can't open dial pad.");
        } */
   }

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title.toString()),
      ),
      body: ListView(
        children: <Widget>[
          imageCarousel,
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            color: Colors.red[400],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.car_repair_outlined),
                Text(
                  loadedProduct.title!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            color: Colors.red[400],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.attach_money),
                Text(
                  loadedProduct.price!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            width: double.infinity,
            child: const Text(
              'DESCRIPCION',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.red[400],
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: double.infinity,
            child: Text(
              loadedProduct.description!,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              softWrap: true,
            ),
          ),
          Container(
            color: Colors.red[400],
            child: Row(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                ),
                const Icon(Icons.airport_shuttle),
                const Text(
                  ' Kilometros : ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  loadedProduct.km.toString(),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: const Text(
              'CONTACTOS',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                ),

                IconButton(
                  icon: const Icon(Icons.call),
                  color: Colors.green[400],
                  onPressed: () {
                    _launchCaller(loadedProduct.phone!);
                  },
                ),
                const Text(' Telefono                             ',style: TextStyle(color: Colors.green),),
                //CONTACTO DE WHATSAPP
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      whatsAppOpen();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green[800],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        'Whatsapp',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
