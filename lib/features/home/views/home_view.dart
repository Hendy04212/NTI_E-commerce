import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/core/utils/app_colors.dart';
import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:ecommerce_shop/core/widgets/custom_promo_slider.dart';
import 'package:ecommerce_shop/core/widgets/custom_search_bar.dart';
import 'package:ecommerce_shop/core/widgets/Custom_app_bar.dart';
import 'package:ecommerce_shop/core/widgets/custom_categories_section.dart';
import 'package:ecommerce_shop/core/helper/my_navigator.dart';
import 'package:ecommerce_shop/features/home/get_product/data/repo/get_product_repo.dart';
import 'package:ecommerce_shop/features/home/get_product/manager/get_product_cubit/get_product_cubit.dart';
import 'package:ecommerce_shop/features/home/get_product/manager/get_product_cubit/get_product_state.dart';
import 'package:ecommerce_shop/features/shoping_cart/views/cart_view.dart';
import 'package:ecommerce_shop/features/shoping_cart/views/shoping_view.dart';
import 'package:ecommerce_shop/features/shoping_cart/views/recent_product.dart';
import 'package:ecommerce_shop/features/profile/view/profile_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ecommerce_shop/features/shoping_cart/views/product-details.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      BlocProvider(
        create: (context) => GetProductsCubit(GetProductsRepo())..getProducts(),
        child: const HomeScreenBodyContent(),
      ),
      const ShopingView(),
      const ProfileView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: InkWell(
        onTap: () {
          MyNavigator.goTo(screen: CartView());
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.loginbtn,
            borderRadius: BorderRadius.circular(40),
          ),
          child: SvgPicture.asset(
            AppAssets.bag,
            width: 32,
            height: 32,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 76,
        child: BottomNavigationBar(
          backgroundColor: AppColors.white,
          currentIndex: _currentIndex,
          selectedItemColor: const Color(0xFFF83758),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: _buildSvgIcon(AppAssets.home, 0, _currentIndex),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: _buildSvgIcon(AppAssets.cart, 1, _currentIndex),
              label: "Items",
            ),
            BottomNavigationBarItem(
              icon: _buildSvgIcon(AppAssets.profile, 2, _currentIndex),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildSvgIcon(String assetPath, int index, int currentIndex) {
  return SvgPicture.asset(
    assetPath,
    width: 24,
    height: 24,
    colorFilter: ColorFilter.mode(
      currentIndex == index ? const Color(0xFFF83758) : Colors.black,
      BlendMode.srcIn,
    ),
  );
}

class HomeScreenBodyContent extends StatelessWidget {
  const HomeScreenBodyContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Static 2 t-shirt products for Recommended section
    final recommendedProducts = [
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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const CustomAppBar(),
          // Search bar with products from BlocBuilder
          BlocBuilder<GetProductsCubit, GetProductsState>(
            builder: (context, state) {
              List<Product> apiProducts = [];
              if (state is GetProductsSuccess) {
                apiProducts = state.products;
              }
              return CustomSearchBar(apiProducts: apiProducts);
            },
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('All Featured', style: AppTextStyle.allFeathureStyle),
            ),
          ),
          const SizedBox(height: 20),
          CustomCategoriesSection(),
          const SizedBox(height: 20),
          const CustomPromoSlider(),
          const SizedBox(height: 20),

          // ========== API Products Section ==========
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Products',
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                height: 22 / 18,
                letterSpacing: 0,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          BlocBuilder<GetProductsCubit, GetProductsState>(
            builder: (context, state) {
              if (state is GetProductsLoading) {
                return const SizedBox(
                  height: 120,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.loginbtn,
                    ),
                  ),
                );
              } else if (state is GetProductsError) {
                return SizedBox(
                  height: 120,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 32),
                        const SizedBox(height: 8),
                        Text(
                          'Failed to load products',
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            context.read<GetProductsCubit>().getProducts();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.loginbtn,
                          ),
                          child: const Text(
                            'Retry',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is GetProductsSuccess) {
                final products = state.products;
                if (products.isEmpty) {
                  return const SizedBox.shrink();
                }
                return SizedBox(
                  height: 260,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          left: index == 0 ? 4 : 8,
                          right: index == products.length - 1 ? 4 : 0,
                        ),
                        child: _ApiProductCard(product: product),
                      );
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 20),

          // ========== Recommended Section ==========
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Recommended',
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                height: 22 / 18,
                letterSpacing: 0,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recommendedProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.51,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              return ProductCard(
                name: recommendedProducts[index]['name'] as String,
                image: recommendedProducts[index]['image'] as String,
                price: recommendedProducts[index]['price'] as double,
                disc: recommendedProducts[index]['disc'] as String,
                rating: recommendedProducts[index]['rating'] as double,
                reviews: recommendedProducts[index]['reviews'] as String,
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Card widget for API products displayed in horizontal scroll
class _ApiProductCard extends StatelessWidget {
  final Product product;

  const _ApiProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetails(
              name: product.name,
              image: product.image,
              price: product.price,
              disc: product.description,
            ));
      },
      child: Container(
        width: 170,
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
            // Product Image
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: product.image.startsWith('http')
                    ? Image.network(
                        product.image,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 60, color: Colors.grey),
                      )
                    : Image.asset(
                        product.image,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            // Product Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${product.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.loginbtn,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 14),
                            const SizedBox(width: 2),
                            Text(
                              product.rating.toString(),
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
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
