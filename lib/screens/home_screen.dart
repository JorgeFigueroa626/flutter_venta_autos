// ignore_for_file: sized_box_for_whitespace, unused_local_variable, prefer_final_fields, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter_autos/models/http_exception.dart';
import 'package:flutter_autos/provider/auth.dart';
import 'package:flutter_autos/screens/product_overview_screen.dart';
import 'package:provider/provider.dart';


enum AuthMode { Signup, Login }

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static const routeName = 'home-screen';

//CREAMOS EL METODO DEL LLAMADO DEL - PRODUCTOVERVIEWSCREEN
  selectProductOverview(BuildContext context) {
    Navigator.of(context).pushNamed(ProductsOverviewScreen.routeName);
  }

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
          whiteOpacity,
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
                  //LAMAMOS A LA FUNCION
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCatState();
}

class _AuthCatState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Ocurrio un error'),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  Future<void> _submit() async {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        //Log user in
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email']!, _authData['password']!);
      } else {
        //sign user up
        await Provider.of<Auth>(context, listen: false)
            .signup(_authData['email']!, _authData['password']!);
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'Este correo ya esta en uso';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Este no es un correo valido';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'Este constraseña es muy debil, incluir mas caracteres';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'No se encontro usuario con este correo';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Constraseña invalidad';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'No se pudo autentificar, intente mas tarde';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _swithAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 320 : 260,
        constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.Signup ? 320 : 260,
        ),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  //
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Mail invalido';
                    }
                   
                  },
                  onSaved: (newValue) {
                    _authData['email'] = newValue!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Constraseña'),
                  obscureText: true,
                  controller: _passwordController,
                  //
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'La  contraseña es muy corta';
                    }
                   
                  },
                  onSaved: (newValue) {
                    _authData['password'] = newValue!;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: const InputDecoration(
                        labelText: 'Confirmar contraseña'),
                    obscureText: true,
                    //
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'La contraseña no coincide';
                            }
                            
                          }
                        : null,
                  ),
                const SizedBox(height: 20),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 8.0),
                      shadowColor: Theme.of(context).primaryColor,
                    ),
                    child: Text(_authMode == AuthMode.Login
                        ? 'INICIO DE SESION'
                        : 'SIGN UP'),
                  ),
                TextButton(
                  onPressed: _swithAuthMode,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 4.0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'REGISTRO' : 'LOGIN'} NUEVO'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
