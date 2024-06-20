import 'package:app_test/models/product.dart';
import 'package:app_test/services/api_service.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  int _currentPage = 1;
  final _products = <Product>[];

  int get currentPage => _currentPage;
  List<Product> get products {
    if (selectedType == null) {
      return _products;
    } else {
      return _products
          .where((element) => element.type == selectedType)
          .toList();
    }
  }

  final scrollController = ScrollController();

  bool _isLoadingMore = false;

  bool get isLoadingMore => _isLoadingMore;

  set isLoadingMore(bool value) {
    _isLoadingMore = value;
    notifyListeners();
  }

  List<bool> buttonValues = [
    false, // autos
    false, // inmuebles
    false, // electronicos
  ];

  ProductType? _selectedType;

  ProductType? get selectedType => _selectedType;

  void selectType(ProductType? type) {
    _selectedType = type;
    notifyListeners();
  }

  final types = {
    0: ProductType.car,
    1: ProductType.property,
    2: ProductType.electronic,
  };

  void selectButton(int index) {
    if (buttonValues[index]) {
      buttonValues[index] = false;
      selectType(null);
      return;
    }

    buttonValues = [false, false, false];
    buttonValues[index] = true;
    selectType(types[index] as ProductType);

    notifyListeners();
  }

  void initController() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!isLoadingMore) {
          isLoadingMore = true;
          await loadMore();
          isLoadingMore = false;
        }
      }
    });
  }

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  set products(List<Product> value) {
    _products.addAll(value);
    notifyListeners();
  }

  final api = ApiService();

  Future<void> getProducts() async {
    try {
      final response = await api.getProductsPaginate(1);
      products = response.products;
    } catch (e) {
      throw Exception('Ocurrio un error al obtener los productos');
    }
  }

  Future<void> loadMore() async {
    currentPage++;
    await getProducts();
  }
}
