import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:ecommerce_shop/core/helper/cart_manager.dart';
import 'package:ecommerce_shop/core/helper/favorite_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetails extends StatefulWidget {
  final String name;
  final String image;
  final double price;
  final String disc;

  const ProductDetails({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.disc,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 1;
  final FavoriteManager _favoriteManager = FavoriteManager();

  @override
  void initState() {
    super.initState();
    _favoriteManager.addListener(_onFavChanged);
  }

  @override
  void dispose() {
    _favoriteManager.removeListener(_onFavChanged);
    super.dispose();
  }

  void _onFavChanged() {
    if (mounted) setState(() {});
  }

  void _toggleFavorite() {
    _favoriteManager.toggleFavorite(FavoriteItemData(
      name: widget.name,
      image: widget.image,
      price: widget.price,
      disc: widget.disc,
    ));
  }

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  void _addToCart() {
    CartManager().addToCart(CartItemData(
      name: widget.name,
      image: widget.image,
      price: widget.price,
      disc: widget.disc,
      quantity: quantity,
    ));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.name} added to cart (x$quantity)'),
        backgroundColor: AppColors.loginbtn,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            AppAssets.arrowback,
            width: 20,
            height: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Product',
          style: AppTextStyle.appbarstylr,
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    widget.image,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: _toggleFavorite,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        _favoriteManager.isFavorite(widget.name, widget.image)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: _favoriteManager.isFavorite(widget.name, widget.image)
                            ? AppColors.loginbtn
                            : Colors.grey,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Vision Alta Men\'s Shoes Size (All Colours) Mens\n Starry Sky Printed Shirt 100% Cotton Fabric',
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        height: 1.4,
                        fontWeight: FontWeight.w100,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${(widget.price * quantity).toStringAsFixed(0)} \$',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.loginbtn,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: _decreaseQuantity,
                            icon: SvgPicture.asset(AppAssets.minus),
                          ),
                          Text(
                            '$quantity',
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            onPressed: _increaseQuantity,
                            icon: SvgPicture.asset(AppAssets.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: 327,
                      height: 52,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.onboardingbtn,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _addToCart,
                        label: const Text(
                          'Add To Cart',
                          style: AppTextStyle.catrbtn,
                        ),
                        icon: SvgPicture.asset(
                          AppAssets.cart,
                          colorFilter: const ColorFilter.mode(
                            AppColors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
