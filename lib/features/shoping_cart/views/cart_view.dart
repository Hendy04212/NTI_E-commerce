import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:ecommerce_shop/core/helper/cart_manager.dart';
import 'package:ecommerce_shop/core/helper/my_navigator.dart';
import 'package:ecommerce_shop/core/translation/translation_keys.dart';
import 'package:ecommerce_shop/features/shoping_cart/views/checkout_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartManager _cartManager = CartManager();

  @override
  void initState() {
    super.initState();
    _cartManager.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    _cartManager.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = _cartManager.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationKeys.cart.tr, style: AppTextStyle.appbarstylr),
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(
            AppAssets.arrowback,
            width: 11,
            height: 11,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      body:
          cartItems.isEmpty
              ? Center(child: Text(TranslationKeys.yourCartIsEmpty.tr))
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        TranslationKeys.shoppingList.tr,
                        style: TextStyle(
                          fontFamily: AppAssets.fontfamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return CartItemWidget(
                            item: item,
                            onIncrease: () => _cartManager.increaseQuantity(index),
                            onDecrease: () => _cartManager.decreaseQuantity(index),
                          );
                        },
                      ),
                    ),
                    Divider(),
                    CheckoutSection(
                      totalPrice: _cartManager.totalPrice,
                      onCheckout: () {
                        MyNavigator.goTo(screen: const CheckoutView());
                      },
                    ),
                  ],
                ),
              ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItemData item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    item.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: AppAssets.fontfamily,
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          item.rating.toString(),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppAssets.fontfamily,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.star, color: AppColors.starcolor, size: 14),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          '\$ ${item.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: AppAssets.fontfamily,
                          ),
                        ),
                        if (item.oldPrice > 0) ...[
                          SizedBox(width: 8),
                          Text(
                            '\$ ${item.oldPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontFamily: AppAssets.fontfamily,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: onDecrease,
                          child: SvgPicture.asset(AppAssets.minus),
                        ),
                        SizedBox(width: 5),
                        Text(
                          item.quantity.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppAssets.fontfamily,
                            fontWeight: FontWeight.w300,
                            color: AppColors.carttext,
                          ),
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: onIncrease,
                          child: SvgPicture.asset(AppAssets.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Divider(color: Colors.grey.shade300, height: 1),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Order (${item.quantity}) :',
                style: TextStyle(
                  fontFamily: AppAssets.fontfamily,
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                '\$ ${(item.price * item.quantity).toStringAsFixed(2)}',
                style: TextStyle(
                  fontFamily: AppAssets.fontfamily,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CheckoutSection extends StatelessWidget {
  final double totalPrice;
  final VoidCallback? onCheckout;

  const CheckoutSection({Key? key, required this.totalPrice, this.onCheckout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          SummaryRow(title: TranslationKeys.subtotal.tr, value: totalPrice),
          SummaryRow(title: TranslationKeys.taxAndFees.tr, value: 3.0),
          SummaryRow(title: TranslationKeys.deliveryFee.tr, value: 2.0),
          Divider(color: Color(0xFFCACACA), thickness: 1.0),
          SummaryRow(
            title: TranslationKeys.orderTotal.tr,
            value: totalPrice + 5.0,
            isTotal: true,
          ),
          SizedBox(height: 16),
          SizedBox(
            width: 327,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.onboardingbtn,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: onCheckout,
              child: Text(TranslationKeys.checkout.tr, style: AppTextStyle.catrbtn),
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String title;
  final double value;
  final bool isTotal;

  const SummaryRow({
    super.key,
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: isTotal ? FontWeight.w400 : FontWeight.normal,
              color: AppColors.carttext,
            ),
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
