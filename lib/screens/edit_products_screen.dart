// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_autos/provider/product.dart';
import 'package:flutter_autos/provider/products.dart';
import 'package:provider/provider.dart';

class EditProductsScreen extends StatefulWidget {
  const EditProductsScreen({super.key});
  static const routeName = 'edit-products-screen';

  @override
  State<EditProductsScreen> createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  //FUNCION PARA SALTAR A OTRA CASILLA DE TEXTO
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _kmFocusNode = FocusNode();
  final _telefonoFocusNode = FocusNode();
  final _whatsappFocusNode = FocusNode();
  final _imageUrl101Controler = TextEditingController();
  final _imageUrl102Controler = TextEditingController();
  final _imageUrl103Controler = TextEditingController();
  final _image101FocusNode = FocusNode();
  final _image102FocusNode = FocusNode();
  final _image103FocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedProduct = Product(
    id: null,
    title: '',
    description: '',
    km: 0,
    price: '',
    phone: '',
    whatsapp: 0,
    imageURL101: '',
    imageURL102: '',
    imageURL103: '',
  );

  var _initValues = {
    'title': '',
    'price': '',
    'description': '',
    'km': '',
    'phone': '',
    'whatsapp': '',
    'imageURL101': '',
    'imageURL102': '',
    'imageURL103': '',
  };

  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _image101FocusNode.addListener(_updateImageUrl101);
    _image102FocusNode.addListener(_updateImageUrl102);
    _image103FocusNode.addListener(_updateImageUrl103);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title!,
          'price': _editedProduct.price!,
          'description': _editedProduct.description!,
          'km': _editedProduct.km.toString(),
          'phone': _editedProduct.phone!,
          'whatsapp': _editedProduct.whatsapp.toString(),
        };
        _imageUrl101Controler.text = _editedProduct.imageURL101!;
        _imageUrl102Controler.text = _editedProduct.imageURL102!;
        _imageUrl103Controler.text = _editedProduct.imageURL103!;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  //METODO PARA LIMPIAR LAS CASILLAS DE TEXTOS
  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _kmFocusNode.dispose();
    _telefonoFocusNode.dispose();
    _whatsappFocusNode.dispose();
    _imageUrl101Controler.dispose();
    _imageUrl102Controler.dispose();
    _imageUrl103Controler.dispose();
    _image101FocusNode.dispose();
    _image102FocusNode.dispose();
    _image103FocusNode.dispose();
    _image101FocusNode.removeListener(_updateImageUrl101);
    _image102FocusNode.removeListener(_updateImageUrl102);
    _image103FocusNode.removeListener(_updateImageUrl103);
    super.dispose();
  }

  void _updateImageUrl101() {
    if (!_image101FocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _updateImageUrl102() {
    if (!_image102FocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _updateImageUrl103() {
    if (!_image103FocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _safeForm() async {
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id!, _editedProduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (e) {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Ocurrio un error'),
                  content: const Text('Algo malo ocurio'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    )
                  ],
                ));
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildBodyText(String title) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Pproduct'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _safeForm,
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      //PARA SALTAR AL SIGUIENTE CAMPO DE TEXTO
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (newValue) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: newValue,
                          description: _editedProduct.description,
                          km: _editedProduct.km,
                          price: _editedProduct.price,
                          phone: _editedProduct.phone,
                          whatsapp: _editedProduct.whatsapp,
                          imageURL101: _editedProduct.imageURL101,
                          imageURL102: _editedProduct.imageURL102,
                          imageURL103: _editedProduct.imageURL103,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      style: const TextStyle(color: Colors.black),
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (newValue) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          km: _editedProduct.km,
                          price: newValue,
                          phone: _editedProduct.phone,
                          whatsapp: _editedProduct.whatsapp,
                          imageURL101: _editedProduct.imageURL101,
                          imageURL102: _editedProduct.imageURL102,
                          imageURL103: _editedProduct.imageURL103,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      maxLines: 3,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_kmFocusNode);
                      },
                      onSaved: (newValue) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: newValue,
                          km: _editedProduct.km,
                          price: _editedProduct.price,
                          phone: _editedProduct.phone,
                          whatsapp: _editedProduct.whatsapp,
                          imageURL101: _editedProduct.imageURL101,
                          imageURL102: _editedProduct.imageURL102,
                          imageURL103: _editedProduct.imageURL103,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['km'],
                      decoration: const InputDecoration(
                        labelText: 'Km',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      focusNode: _kmFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_telefonoFocusNode);
                      },
                      onSaved: (newValue) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          km: int.parse(newValue!),
                          price: _editedProduct.price,
                          phone: _editedProduct.phone,
                          whatsapp: _editedProduct.whatsapp,
                          imageURL101: _editedProduct.imageURL101,
                          imageURL102: _editedProduct.imageURL102,
                          imageURL103: _editedProduct.imageURL103,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['phone'],
                      decoration: const InputDecoration(
                        labelText: 'Telefono',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      focusNode: _telefonoFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_whatsappFocusNode);
                      },
                      onSaved: (newValue) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          km: _editedProduct.km,
                          price: _editedProduct.price,
                          phone: newValue,
                          whatsapp: _editedProduct.whatsapp,
                          imageURL101: _editedProduct.imageURL101,
                          imageURL102: _editedProduct.imageURL102,
                          imageURL103: _editedProduct.imageURL103,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['whatsapp'],
                      decoration: const InputDecoration(
                        labelText: 'Whastapp',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      focusNode: _whatsappFocusNode,
                      onSaved: (newValue) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          km: _editedProduct.km,
                          price: _editedProduct.price,
                          phone: _editedProduct.phone,
                          whatsapp: int.parse(newValue!),
                          imageURL101: _editedProduct.imageURL101,
                          imageURL102: _editedProduct.imageURL102,
                          imageURL103: _editedProduct.imageURL103,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    buildBodyText('Imagenes'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.red,
                            ),
                          ),
                          child: _imageUrl101Controler.text.isEmpty
                              ? const Text('Ingrese la Url de la image')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrl101Controler.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Url de la image'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrl101Controler,
                            focusNode: _image101FocusNode,
                            onSaved: (newValue) {
                              _editedProduct = Product(
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                km: _editedProduct.km,
                                price: _editedProduct.price,
                                phone: _editedProduct.phone,
                                whatsapp: _editedProduct.whatsapp,
                                imageURL101: newValue,
                                imageURL102: _editedProduct.imageURL102,
                                imageURL103: _editedProduct.imageURL103,
                                isFavorite: _editedProduct.isFavorite,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.red,
                            ),
                          ),
                          child: _imageUrl102Controler.text.isEmpty
                              ? const Text('Ingrese la Url de la image')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrl101Controler.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Url de la image'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrl102Controler,
                            focusNode: _image102FocusNode,
                            onSaved: (newValue) {
                              _editedProduct = Product(
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                km: _editedProduct.km,
                                price: _editedProduct.price,
                                phone: _editedProduct.phone,
                                whatsapp: _editedProduct.whatsapp,
                                imageURL101: _editedProduct.imageURL101,
                                imageURL102: newValue,
                                imageURL103: _editedProduct.imageURL103,
                                isFavorite: _editedProduct.isFavorite,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.red,
                            ),
                          ),
                          child: _imageUrl103Controler.text.isEmpty
                              ? const Text('Ingrese la Url de la image')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrl101Controler.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Url de la image'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrl103Controler,
                            focusNode: _image103FocusNode,
                            onFieldSubmitted: (_) {
                              _safeForm();
                            },
                            onSaved: (newValue) {
                              _editedProduct = Product(
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                km: _editedProduct.km,
                                price: _editedProduct.price,
                                phone: _editedProduct.phone,
                                whatsapp: _editedProduct.whatsapp,
                                imageURL101: _editedProduct.imageURL101,
                                imageURL102: _editedProduct.imageURL102,
                                imageURL103: newValue,
                                isFavorite: _editedProduct.isFavorite,
                              );
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
