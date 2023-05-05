// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

//IMAGEN DEL BANER
  final backgroud = Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
      image: AssetImage('images/back.jpg'),
      fit: BoxFit.cover,
    )),
  );

//OSCURE EL BANER
  final whiteOpacity = Container(
    color: Colors.white38,
  );

  final logo = Image.asset(
    'images/logo.png',
    width: 300,
    height: 300,
  );

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      //INVOCAMOS LA LLAMA EN LA PANTALLA
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          //LLAMAMOS A LA FUNCION
          backgroud,
          //whiteOpacity,
          //LLAMAMOS A LA FUNCION
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SafeArea(
                    child: Column(
                      children: <Widget>[
                        logo,
                      ],
                    ),
                  ),
                  const Center(child: Text('Cargando...')),

                  //LAMAMOS A LA FUNCION
                  /*Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  )*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

  /*@override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Cargando...'),
      ),
    );
  }
}*/