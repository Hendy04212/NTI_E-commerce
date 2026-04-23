import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final Map<String, dynamic> order;
  final VoidCallback? onCancel;
  final VoidCallback? onComplete;

  const OrderItem({
    super.key,
    required this.order,
    this.onCancel,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime orderDate =
        order['orderDate'] is DateTime ? order['orderDate'] : DateTime.now();
    final String formattedDate = DateFormat(
      'dd/MM/yyyy h:mm a',
    ).format(orderDate);
    final int quantity = order['quantity'] ?? 1;
    final String status = order['status'] ?? 'Active';

    return Container(
      width: 338,
      height: 106,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 103,
            height: 106,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: order['image'].toString().startsWith('http')
                    ? NetworkImage(order['image']) as ImageProvider
                    : AssetImage(order['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// تفاصيل الطلب
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// العنوان والسعر
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        order['name'],
                        style: AppTextStyle.light10(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "\$ ${order['price']}",
                      style: AppTextStyle.light10().copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                /// التاريخ وعدد القطع
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formattedDate,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      "$quantity item${quantity > 1 ? 's' : ''}",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                if (status == 'Active')
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 103,
                          height: 21,
                          child: ElevatedButton(
                            onPressed: onCancel,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColors.white,
                              backgroundColor: AppColors.onboardingbtn,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: AppTextStyle.customTextStyle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SizedBox(
                          width: 103,
                          height: 21,
                          child: ElevatedButton(
                            onPressed: onComplete,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColors.white,
                              backgroundColor: AppColors.onboardingbtn,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "Track Driver",
                              style: AppTextStyle.customTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                else if (status == 'Completed')
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.loginbtn,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Order delivered",
                        style: TextStyle(
                          color: AppColors.loginbtn,
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  )
                else if (status == 'Canceled')
                  Row(
                    children: [
                      Icon(Icons.cancel, color: AppColors.loginbtn, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "Order Cancelled",
                        style: TextStyle(
                          color: AppColors.loginbtn,
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
