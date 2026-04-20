/// Global cart manager to share cart state between ProductDetails, CartView, and OrdersView.
/// Uses a simple singleton pattern with ChangeNotifier for reactivity.
import 'package:flutter/foundation.dart';

class CartItemData {
  final String name;
  final String image;
  final double price;
  final double oldPrice;
  final double rating;
  final String disc;
  int quantity;

  CartItemData({
    required this.name,
    required this.image,
    required this.price,
    this.oldPrice = 0,
    this.rating = 4.5,
    required this.disc,
    this.quantity = 1,
  });
}

class OrderItemData {
  final String name;
  final String image;
  final double price;
  final int quantity;
  String status;
  final DateTime orderDate;

  OrderItemData({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    this.status = 'Active',
    DateTime? orderDate,
  }) : orderDate = orderDate ?? DateTime.now();
}

class CartManager extends ChangeNotifier {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal() {
    // Seed default cart items
    if (_cartItems.isEmpty) {
      _cartItems.addAll([
        CartItemData(
          name: "Women's Casual Wear",
          image: 'assets/images/cart1.png',
          price: 34.00,
          oldPrice: 64.00,
          rating: 4.8,
          disc: "Women's Casual Wear Collection",
        ),
        CartItemData(
          name: "Men's Jacket",
          image: 'assets/images/cart2.png',
          price: 45.00,
          oldPrice: 67.00,
          rating: 4.7,
          disc: "Men's Jacket Premium Quality",
        ),
      ]);
    }
  }

  final List<CartItemData> _cartItems = [];
  final List<OrderItemData> _orders = [];

  List<CartItemData> get cartItems => List.unmodifiable(_cartItems);
  List<OrderItemData> get orders => List.unmodifiable(_orders);

  void addToCart(CartItemData item) {
    // Check if item already exists in cart
    final existingIndex = _cartItems.indexWhere((e) => e.name == item.name && e.image == item.image);
    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity += item.quantity;
    } else {
      _cartItems.add(item);
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

  void increaseQuantity(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < _cartItems.length) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  double get totalPrice =>
      _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void checkout() {
    // Move cart items to orders
    for (final item in _cartItems) {
      _orders.add(OrderItemData(
        name: item.name,
        image: item.image,
        price: item.price,
        quantity: item.quantity,
        status: 'Active',
      ));
    }
    _cartItems.clear();
    notifyListeners();
  }

  void cancelOrder(int index) {
    if (index >= 0 && index < _orders.length) {
      _orders[index].status = 'Canceled';
      notifyListeners();
    }
  }

  void completeOrder(int index) {
    if (index >= 0 && index < _orders.length) {
      _orders[index].status = 'Completed';
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
