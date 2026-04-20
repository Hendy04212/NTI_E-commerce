import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:ecommerce_shop/core/helper/favorite_manager.dart';
import 'package:ecommerce_shop/core/translation/translation_keys.dart';
import 'package:ecommerce_shop/features/shoping_cart/views/product-details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyFavView extends StatefulWidget {
  const MyFavView({super.key});

  @override
  State<MyFavView> createState() => _MyFavViewState();
}

class _MyFavViewState extends State<MyFavView> {
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

  @override
  Widget build(BuildContext context) {
    final favorites = _favoriteManager.favorites;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(
            AppAssets.arrowback,
            fit: BoxFit.scaleDown,
          ),
        ),
        centerTitle: true,
        title: Text(
          TranslationKeys.myFavorites.tr,
          style: AppTextStyle.appbarstylr,
        ),
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: AppColors.loginbtn.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    TranslationKeys.noFavoritesYet.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.loginbtn,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: favorites.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.51,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  final item = favorites[index];
                  return _FavoriteProductCard(
                    item: item,
                    onRemove: () {
                      _favoriteManager.removeFromFavorites(index);
                    },
                  );
                },
              ),
            ),
    );
  }
}

class _FavoriteProductCard extends StatelessWidget {
  final FavoriteItemData item;
  final VoidCallback onRemove;

  const _FavoriteProductCard({
    required this.item,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              name: item.name,
              image: item.image,
              price: item.price,
              disc: item.disc,
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
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.asset(
                      item.image,
                      height: 196,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onRemove,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 16,
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.loginbtn,
                        size: 18,
                      ),
                    ),
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
                    Text(item.name, style: AppTextStyle.nameStyle),
                    SizedBox(height: 5),
                    Text(
                      item.disc,
                      style: AppTextStyle.discStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '\$ ${item.price.toStringAsFixed(0)}',
                      style: AppTextStyle.priceStyle,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.star,
                            color: AppColors.starcolor, size: 14),
                        SizedBox(width: 4),
                        Text(
                          item.rating.toString(),
                          style: AppTextStyle.reviwStyle,
                        ),
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
