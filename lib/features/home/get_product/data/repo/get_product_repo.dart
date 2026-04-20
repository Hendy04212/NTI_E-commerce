import 'package:ecommerce_shop/core/network/api_helper.dart';
import 'package:ecommerce_shop/core/network/api_response.dart' show ApiResponse;

class Product {
  final int id;
  final String name;
  final String image;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'] ?? '', // تأكد من وجود المفتاح
      price: double.tryParse(json['price'].toString()) ?? 0.0,
    );
  }
}

class GetProductsRepo {
  Future<List<Product>> getProducts() async {
    ApiResponse response = await ApiHelper().getProducts();

    if (!response.status) throw Exception(response.message);

    final List rawList = response.data['products'] ?? [];

    // طباعة لفحص البيانات في الـ console
    print('Raw products data from API: $rawList');

    return rawList.map((json) => Product.fromJson(json)).toList();
  }
}
