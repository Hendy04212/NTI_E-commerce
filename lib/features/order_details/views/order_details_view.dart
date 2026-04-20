import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:ecommerce_shop/core/helper/cart_manager.dart';
import 'package:ecommerce_shop/core/helper/my_navigator.dart';
import 'package:ecommerce_shop/core/translation/translation_keys.dart';
import 'package:ecommerce_shop/features/order_details/views/Orders_View.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Data model for items displayed in Order Details
class OrderDetailItem {
  final String name;
  final String image;
  final double price;
  final int quantity;

  const OrderDetailItem({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });
}

class OrderDetailsView extends StatefulWidget {
  final List<OrderDetailItem> orderItems;
  final double totalPrice;

  const OrderDetailsView({
    super.key,
    required this.orderItems,
    required this.totalPrice,
  });

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  final CartManager _cartManager = CartManager();
  String _orderStatus = 'Active';
  late final String _orderNumber;
  late final String _orderDate;

  @override
  void initState() {
    super.initState();
    _orderNumber = '00${_cartManager.orders.length}';
    _orderDate = DateFormat('dd MMM, hh:mm a').format(DateTime.now());
  }

  void _cancelOrder() {
    // Cancel all orders from this checkout batch
    final orders = _cartManager.orders;
    for (int i = orders.length - 1;
        i >= 0 && i >= orders.length - widget.orderItems.length;
        i--) {
      if (orders[i].status == 'Active') {
        _cartManager.cancelOrder(i);
      }
    }
    setState(() {
      _orderStatus = 'Canceled';
    });
  }

  void _completeOrder() {
    // Complete all orders from this checkout batch
    final orders = _cartManager.orders;
    for (int i = orders.length - 1;
        i >= 0 && i >= orders.length - widget.orderItems.length;
        i--) {
      if (orders[i].status == 'Active') {
        _cartManager.completeOrder(i);
      }
    }
    setState(() {
      _orderStatus = 'Completed';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            // Go back to Orders View
            MyNavigator.goTo(
              screen: const OrdersView(),
              isReplace: true,
            );
          },
          child: SvgPicture.asset(
            AppAssets.arrowback,
            width: 11,
            height: 11,
            fit: BoxFit.scaleDown,
          ),
        ),
        centerTitle: true,
        title: Text(TranslationKeys.orderDetails.tr, style: AppTextStyle.appbarstylr),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Number & Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order No. $_orderNumber',
                            style: TextStyle(
                              fontFamily: AppAssets.fontfamily,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _orderDate,
                            style: TextStyle(
                              fontFamily: AppAssets.fontfamily,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        _orderStatus == 'Canceled' ? 'Cancelled' : _orderStatus,
                        style: TextStyle(
                          fontFamily: AppAssets.fontfamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: _orderStatus == 'Active'
                              ? AppColors.appbartext
                              : _orderStatus == 'Completed'
                                  ? Colors.green
                                  : AppColors.loginbtn,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Order Items
                  ...widget.orderItems
                      .map((item) => _buildOrderDetailItem(item)),

                  const SizedBox(height: 16),

                  // Summary Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          TranslationKeys.subtotal.tr,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            color: AppColors.carttext,
                          ),
                        ),
                        Text(
                          '\$ ${widget.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          TranslationKeys.taxAndFees.tr,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            color: AppColors.carttext,
                          ),
                        ),
                        Text(
                          '\$ 3.00',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          TranslationKeys.deliveryFee.tr,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            color: AppColors.carttext,
                          ),
                        ),
                        Text(
                          '\$ 2.00',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Color(0xFFCACACA), thickness: 1.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          TranslationKeys.orderTotal.tr,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: AppColors.carttext,
                          ),
                        ),
                        Text(
                          '\$ ${(widget.totalPrice + 5.0).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Buttons
          if (_orderStatus == 'Active')
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.onboardingbtn,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _cancelOrder,
                        child: Text(
                          TranslationKeys.cancelOrder.tr,
                          style: TextStyle(
                            fontFamily: AppAssets.fontfamily,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.onboardingbtn,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _completeOrder,
                        child: Text(
                          TranslationKeys.trackDriver.tr,
                          style: TextStyle(
                            fontFamily: AppAssets.fontfamily,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOrderDetailItem(OrderDetailItem item) {
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
                        Icon(Icons.star,
                            color: AppColors.starcolor, size: 14),
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
