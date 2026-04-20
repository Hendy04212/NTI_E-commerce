import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:ecommerce_shop/features/shoping_cart/views/product-details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecentProducts extends StatelessWidget {
  RecentProducts({super.key});

  final productList = [
    {
      'name': 'Mens Starry',
      'image': AppAssets.tshirt,
      'price': 399.0,
      'disc': 'Mens Starry Sky Printed Shirt\n100% Cotton Fabric',
      'rating': 4.5,
      'reviews': '1,52,344',
    },
    {
      'name': 'Mens Starry',
      'image': AppAssets.tshirt,
      'price': 399.0,
      'disc': 'Mens Starry Sky Printed Shirt\n100% Cotton Fabric',
      'rating': 4.5,
      'reviews': '1,52,344',
    },
    {
      'name': 'Mens Starry',
      'image': AppAssets.tshirt,
      'price': 399.0,
      'disc': 'Mens Starry Sky Printed Shirt\n100% Cotton Fabric',
      'rating': 4.5,
      'reviews': '1,52,344',
    },
    {
      'name': 'Mens Starry',
      'image': AppAssets.tshirt,
      'price': 399.0,
      'disc': 'Mens Starry Sky Printed Shirt\n100% Cotton Fabric',
      'rating': 4.5,
      'reviews': '1,52,344',
    },
    {
      'name': 'Mens Starry',
      'image': AppAssets.tshirt,
      'price': 399.0,
      'disc': 'Mens Starry Sky Printed Shirt\n100% Cotton Fabric',
      'rating': 4.5,
      'reviews': '1,52,344',
    },
    {
      'name': 'Mens Starry',
      'image': AppAssets.tshirt,
      'price': 399.0,
      'disc': 'Mens Starry Sky Printed Shirt\n100% Cotton Fabric',
      'rating': 4.5,
      'reviews': '1,52,344',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: productList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.51,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return ProductCard(
          name: productList[index]['name'] as String,
          image: productList[index]['image'] as String,
          price: productList[index]['price'] as double,
          disc: productList[index]['disc'] as String,
          rating: productList[index]['rating'] as double,
          reviews: productList[index]['reviews'] as String,
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String image;
  final double price;
  final String disc;
  final double rating;
  final String reviews;

  const ProductCard({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.disc,
    required this.rating,
    required this.reviews,
  });

  List<Widget> buildStars() {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    for (int i = 0; i < fullStars; i++) {
      stars.add(SvgPicture.asset(
        AppAssets.star,
        width: 11,
        height: 11,
        fit: BoxFit.scaleDown,
        colorFilter: ColorFilter.mode(AppColors.starcolor, BlendMode.srcIn),
      ));
    }

    if (hasHalfStar) {
      stars.add(SvgPicture.asset(
        AppAssets.halfstar,
        width: 11,
        height: 11,
        fit: BoxFit.scaleDown,
      ));
    }

    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              name: name,
              image: image,
              price: price,
              disc: disc,
            ),
          ),
        );
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  height: 196,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    image,
                    height: 196,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyle.nameStyle),
                    SizedBox(height: 5),
                    Text(disc, style: AppTextStyle.discStyle, maxLines: 2, overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 5),
                    Text('₹$price', style: AppTextStyle.priceStyle),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        ...buildStars(),
                        SizedBox(width: 5),
                        Text(reviews, style: AppTextStyle.reviwStyle),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
