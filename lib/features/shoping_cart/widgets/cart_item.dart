class CartItem {
  final String name;
  final double price;
  final double oldPrice;
  final double rating;
  int quantity;
  final String image;

  CartItem({
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.quantity,
    required this.image,
  });
}
