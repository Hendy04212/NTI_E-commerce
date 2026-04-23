import 'package:ecommerce_shop/core/network/api_helper.dart';
import 'package:ecommerce_shop/core/network/api_response.dart' show ApiResponse;

class Product {
  final int id;
  final String name;
  final String image;
  final double price;
  final String description;
  final double rating;
  final bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.description = '',
    this.rating = 4.5,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image_path'] ?? json['image'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description'] ?? '',
      rating: double.tryParse(json['rating'].toString()) ?? 4.5,
      isFavorite: json['is_favorite'] ?? false,
    );
  }
}

class GetProductsRepo {
  /// Only allow these product IDs (clothing items only)
  /// id 4 = White Jacket, id 5 = t shirt
  static const _allowedIds = [4, 5];

  /// Clothing-related keywords (if product name/desc contains any of these, keep it)
  static const _clothingKeywords = [
    'jacket',
    'shirt',
    't shirt',
    't-shirt',
    'tshirt',
    'hoodie',
    'pants',
    'jeans',
    'dress',
    'skirt',
    'coat',
    'sweater',
    'blouse',
    'shorts',
    'suit',
    'wear',
    'cloth',
    'fashion',
    'ملابس',
    'قميص',
    'بنطلون',
    'جاكيت',
    'فستان',
    'تحيا',
  ];

  bool _isClothingProduct(Product product) {
    // Allow by known ID
    if (_allowedIds.contains(product.id)) {
      return true;
    }

    // Otherwise check if name/description contains clothing keywords
    final nameLower = product.name.toLowerCase();
    final descLower = product.description.toLowerCase();
    for (final keyword in _clothingKeywords) {
      if (nameLower.contains(keyword) || descLower.contains(keyword)) {
        return true;
      }
    }

    // If none match, exclude it
    return false;
  }

  Future<List<Product>> getProducts() async {
    ApiResponse response = await ApiHelper().getProducts();

    if (!response.status) throw Exception(response.message);

    final List rawList = response.data['products'] ?? [];

    // طباعة لفحص البيانات في الـ console
    print('Raw products data from API: $rawList');

    final allProducts = rawList.map((json) => Product.fromJson(json)).toList();

    // Filter to only keep clothing products
    return allProducts.where(_isClothingProduct).toList();
  }
}
