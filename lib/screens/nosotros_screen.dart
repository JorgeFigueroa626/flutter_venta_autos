// ignore_for_file: sized_box_for_whitespace, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NosotrosScreen extends StatelessWidget {
  const NosotrosScreen({super.key});

  static const routeName = 'nosotros-screen';

  @override
  Widget build(BuildContext context) {
    Widget buildTitleText(String title) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    Widget buildBodyText(String title) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }

    void whatsAppOpen() async {
      await FlutterLaunch.launchWhatsapp(
          phone: '59175369196', message: 'Quiero anunciarme');
    }

    /*void whatsAppOpen() async {
    bool whatsapp = await FlutterLaunch.hasApp(name: "whatsapp");

    if (whatsapp) {
      await FlutterLaunch.launchWhatsapp(
          phone: "5534992016100", message: "Hello, flutter_launch");
    } else {
      setState(() {
        err = false;
        msgErr = '';
      });
    }*/

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nosotros'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                'images/backAnunciatelogo.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildTitleText('Contactos'),
                buildBodyText('Envianos un mail a: '),
                InkWell(
                  onTap: () {
                    launchUrlString(
                        "mailto:<jlfigueroa626@gmail.com>?subject=Quiero anunciarme");
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'jlfigueroa626@gmail.com',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                buildTitleText('o un Whatsapp: '),
                GestureDetector(
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
                buildBodyText(''),
                Center(child: buildTitleText('QUIENES SOMOS?')),
                buildBodyText('Somos..')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
