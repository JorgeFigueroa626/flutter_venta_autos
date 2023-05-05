// ignore_for_file: avoid_print, import_of_legacy_library_into_null_safe, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_autos/models/http_exception.dart';
import 'package:flutter_autos/provider/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    Product(
      id: 'a1',
      title: 'Sentarl 2005',
      description: 'Muy bueno',
      km: 160000,
      price: '98.000',
      imageURL101:
          'https://www.nissan.com.bo/content/dam/Nissan/BO/vehicles/Versa_MY20/360Bolivia/ROJOBURDEOS/20TDImexlhd_L02Dw004_008.jpeg.ximg.c1h.360.jpeg',
      imageURL102:
          'https://www.nissan-cdn.net/content/dam/Nissan/BO/vehicles/Versa_MY20/launch/vlp/VERSA_Herobanner_VLP_04_desktop_3000x1500.jpg.ximg.l_full_m.smart.jpg',
      imageURL103:
          'https://www.nissan.com.bo/content/dam/Nissan/BO/vehicles/Versa_MY20/launch/design/VERSA_Gallery_exterior_05_horizontal_3200x1800.jpg',
      phone: '+591 75369196',
      whatsapp: 59175369196,
    ),
    Product(
      id: 'a2',
      title: 'Toyota 2006',
      description: 'Muy Cool',
      km: 170000,
      price: '18.000',
      imageURL101:
          'https://www.nissan-cdn.net/content/dam/Nissan/BO/vehicles/Versa_MY20/launch/vlp/VERSA_Herobanner_VLP_04_desktop_3000x1500.jpg.ximg.l_full_m.smart.jpg',
      imageURL102:
          'https://www.nissan.com.bo/content/dam/Nissan/BO/vehicles/Versa_MY20/launch/design/VERSA_Gallery_exterior_05_horizontal_3200x1800.jpg',
      imageURL103:
          'https://www.nissan.com.bo/content/dam/Nissan/BO/vehicles/Versa_MY20/360Bolivia/ROJOBURDEOS/20TDImexlhd_L02Dw004_008.jpeg.ximg.c1h.360.jpeg',
      phone: '+591 75369196',
      whatsapp: 59175369196,
    ),
  ];

  final String authToken;
  final String userId;
  Products(this.authToken, this.userId, this._items);

  List<Product> get items {
    return [..._items];
  }

  //FUNCION DE MARCAR FAVORITOS
  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  //FUNCION PARA EXTRAER DE  LA BASE DATOS
  Future<void> fetchAndSetProducts() async {
    var url =
        'https://ventasautos-8233c-default-rtdb.firebaseio.com/product.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          'https://ventasautos-8233c-default-rtdb.firebaseio.com/userFavorites/$userId/.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);

      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.insert(
            (0),
            Product(
              id: prodId,
              title: prodData['title'],
              price: prodData['price'],
              description: prodData['description'],
              km: prodData['km'],
              phone: prodData['phone'],
              whatsapp: prodData['whatsapp'],
              imageURL101: prodData['imageURL101'],
              imageURL102: prodData['imageURL102'],
              imageURL103: prodData['imageURL103'],
              isFavorite:
                  favoriteData == null ? false : favoriteData[prodId] ?? false,
            ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  //FUNCION PARA CREAR EN LA BASE DE DATOS EL PRODUCTO CON LA URL
  Future<void> addProduct(Product product) async {
    final url =
        'https://ventasautos-8233c-default-rtdb.firebaseio.com/product.json?auth=$authToken';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'km': product.km,
            'phone': product.phone,
            'whatsapp': product.whatsapp,
            'imageURL101': product.imageURL101,
            'imageURL102': product.imageURL102,
            'imageURL103': product.imageURL103,
          }));
      final newProduct = Product(
        title: product.title,
        description: product.description,
        km: product.km,
        price: product.price,
        phone: product.phone,
        whatsapp: product.whatsapp,
        imageURL101: product.imageURL101,
        imageURL102: product.imageURL102,
        imageURL103: product.imageURL103,
        isFavorite: product.isFavorite,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      //_items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  //FUNCION DE EDITAR EL PRODUCTO
  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://ventasautos-8233c-default-rtdb.firebaseio.com/product/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'price': newProduct.price,
            'description': newProduct.description,
            'km': newProduct.km,
            'phone': newProduct.phone,
            'whatsapp': newProduct.whatsapp,
            'imageURL101': newProduct.imageURL101,
            'imageURL102': newProduct.imageURL102,
            'imageURL103': newProduct.imageURL103,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  //FUNCION DE ELIMINAR EL PRODUCTO
  Future<void> deleteProducts(String id) async {
    final url =
        'https://ventasautos-8233c-default-rtdb.firebaseio.com/product/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('No se borro el producto');
    }
    existingProduct = null;
  }
}
