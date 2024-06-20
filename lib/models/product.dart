import 'dart:math';

class Products {
  final List<Product> products;

  Products({
    required this.products,
  });

  factory Products.fromJson(List<dynamic> parsedJson) {
    List<Product> products = <Product>[];
    products = parsedJson.map((i) => Product.fromJson(i)).toList();

    return Products(
      products: products,
    );
  }
}

enum ProductType { car, property, electronic }

extension GetRandomProductType on ProductType {
  static ProductType getRandomProductType() =>
      ProductType.values[Random().nextInt(ProductType.values.length)];
}

class Product {
  final String title;
  final ProductType type;
  final String price;
  final String image;
  final String longitude;
  final String latitude;
  final String id;
  final String description;

  Product({
    required this.title,
    required this.type,
    required this.price,
    required this.image,
    required this.longitude,
    required this.latitude,
    required this.id,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      type: GetRandomProductType.getRandomProductType(),
      price: json['price'],
      image: json['image'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      id: json['id'],
      description: json['description'],
    );
  }
}
