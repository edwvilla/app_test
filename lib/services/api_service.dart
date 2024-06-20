import 'dart:developer';

import 'package:app_test/models/product.dart';
import 'package:dio/dio.dart';

class ApiService {
  final dio = Dio();

  Future<Products> getProducts() async {
    try {
      final response =
          await dio.get('https://666bdf3249dbc5d7145b8996.mockapi.io/Product');
      return Products.fromJson(response.data);
    } catch (e) {
      log(e.toString());
      throw Exception('Ocurrio un error al obtener los productos');
    }
  }

  Future<Products> getProductsPaginate(int page) async {
    // simulate a pagination
    try {
      final products = await getProducts();
      final start = page * 5;
      final end = start + 5;
      final productsPaginate = products.products.sublist(start, end);
      return Products(products: productsPaginate);
    } catch (e) {
      log(e.toString());
      throw Exception('Ocurrio un error al obtener los productos');
    }
  }
}
