import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:ecommerce_shop/core/helper/cart_manager.dart';
import 'package:ecommerce_shop/core/helper/my_navigator.dart';
import 'package:ecommerce_shop/core/translation/translation_keys.dart';
import 'package:ecommerce_shop/features/order_details/views/order_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartManager = CartManager();
    final cartItems = cartManager.cartItems;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(
            AppAssets.arrowback,
            width: 11,
            height: 11,
            fit: BoxFit.scaleDown,
          ),
        ),
        centerTitle: true,
        title: Text(TranslationKeys.checkout.tr, style: AppTextStyle.appbarstylr),
      ),
      body: cartItems.isEmpty
          ? Center(child: Text(TranslationKeys.noItemsToCheckout.tr))
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Delivery Address Section
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: Colors.black, size: 20),
                            const SizedBox(width: 6),
                            Text(
                              TranslationKeys.deliveryAddress.tr,
                              style: TextStyle(
                                fontFamily: AppAssets.fontfamily,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Address',
                                      style: TextStyle(
                                        fontFamily: AppAssets.fontfamily,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      TranslationKeys.addressHint.tr,
                                      style: TextStyle(
                                        fontFamily: AppAssets.fontfamily,
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.loginbtn,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Shopping List Title
                        Text(
                          TranslationKeys.shoppingList.tr,
                          style: TextStyle(
                            fontFamily: AppAssets.fontfamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Cart Items List
                        ...cartItems.map((item) => _buildCheckoutItem(item)),
                      ],
                    ),
                  ),
                ),

                // Place Order Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 327,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.onboardingbtn,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        // Save items info before checkout clears them
                        final orderItems = cartItems
                            .map((item) => OrderDetailItem(
                                  name: item.name,
                                  image: item.image,
                                  price: item.price,
                                  quantity: item.quantity,
                                ))
                            .toList();
                        final totalPrice = cartManager.totalPrice;

                        // Checkout - moves items to orders
                        cartManager.checkout();

                        // Navigate to Order Details
                        MyNavigator.goTo(
                          screen: OrderDetailsView(
                            orderItems: orderItems,
                            totalPrice: totalPrice,
                          ),
                        );
                      },
                      child: Text(TranslationKeys.placeOrder.tr, style: AppTextStyle.catrbtn),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildCheckoutItem(CartItemData item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
              // Product Image
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    item.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontFamily: AppAssets.fontfamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: AppColors.starcolor, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '4.8',
                          style: TextStyle(
                            fontFamily: AppAssets.fontfamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item.quantity} item${item.quantity > 1 ? 's' : ''}',
                      style: TextStyle(
                        fontFamily: AppAssets.fontfamily,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '\$ ${item.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontFamily: AppAssets.fontfamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '\$ ${(item.price * 1.5).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontFamily: AppAssets.fontfamily,
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Total Order Row
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
