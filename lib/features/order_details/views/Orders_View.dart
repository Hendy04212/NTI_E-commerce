import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:ecommerce_shop/core/helper/cart_manager.dart';
import 'package:ecommerce_shop/core/translation/translation_keys.dart';
import 'package:ecommerce_shop/features/order_details/views/ordered_Items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';



class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  String selectedStatus = "Active";
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
    final allOrders = _cartManager.orders;
    final filteredOrders = allOrders
        .where((order) => order.status == selectedStatus)
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(
            AppAssets.arrowback,
            height: 11,
            width: 11,
            fit: BoxFit.scaleDown,
          ),
        ),
        centerTitle: true,
        title: Text(
          TranslationKeys.myOrders.tr,
          style: AppTextStyle.appbarstylr,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildFilterButton("Active", Color(0xFFFFFFFF)),
              buildFilterButton("Completed", Color(0xFFFFFFFF)),
              buildFilterButton("Canceled", Color(0xFFFFFFFF)),
            ],
          ),
          Expanded(
            child: filteredOrders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 80,
                          color: AppColors.loginbtn.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          TranslationKeys.noOrdersMessage.tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.loginbtn,
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      // Find the real index in the full orders list
                      final realIndex = allOrders.indexOf(order);
                      return OrderItem(
                        order: {
                          'name': order.name,
                          'price': order.price,
                          'image': order.image,
                          'status': order.status,
                          'quantity': order.quantity,
                          'orderDate': order.orderDate,
                        },
                        onCancel: () {
                          _cartManager.cancelOrder(realIndex);
                          setState(() {
                            selectedStatus = 'Canceled';
                          });
                        },
                        onComplete: () {
                          _cartManager.completeOrder(realIndex);
                          setState(() {
                            selectedStatus = 'Completed';
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildFilterButton(String status, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedStatus = status;
          });
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: color,
          backgroundColor: selectedStatus == status
              ? AppColors.loginbtn
              : Color(0XFFFFCCD5),
        ),
        child: Text(
          status,
        ),
      ),
    );
  }
}
