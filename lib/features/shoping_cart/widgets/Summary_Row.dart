import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:flutter/material.dart';


class SummaryRow extends StatelessWidget {
  final String title;
  final double value;
  final bool isTotal;

  const SummaryRow(
      {super.key,
      required this.title,
      required this.value,
      this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: isTotal ? FontWeight.w400 : FontWeight.normal,
                  color: AppColors.carttext)),
          Text('\$${value.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  color: isTotal ? Colors.red : Colors.black)),
        ],
      ),
    );
  }
}
