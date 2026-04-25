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

class HomeScreenBodyContent extends StatefulWidget {
  const HomeScreenBodyContent({super.key});

  @override
  State<HomeScreenBodyContent> createState() => _HomeScreenBodyContentState();
}

class _HomeScreenBodyContentState extends State<HomeScreenBodyContent>
    with TickerProviderStateMixin {
  /// -1 = no category selected, products hidden
  int _selectedCategoryIndex = -1;
  bool _showProducts = false;

  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  // Static recommended products
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

  /// Category names matching CustomCategoriesSection order
  final _categoryNames = ['Beauty', 'Fashion', 'Kids', 'Men', 'Women'];

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _onCategoryTap(int index) {
    setState(() {
      if (_selectedCategoryIndex == index) {
        // Deselect – hide products
        _selectedCategoryIndex = -1;
        _showProducts = false;
        _slideController.reverse();
        _fadeController.reverse();
      } else {
        // Select – show products
        _selectedCategoryIndex = index;
        _showProducts = true;
        _slideController.forward(from: 0);
        _fadeController.forward(from: 0);
      }
    });
  }

  String get _selectedCategoryName {
    if (_selectedCategoryIndex < 0 ||
        _selectedCategoryIndex >= _categoryNames.length) {
      return '';
    }
    return _categoryNames[_selectedCategoryIndex];
  }

  @override
  Widget build(BuildContext context) {
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

          // ===== Interactive Categories =====
          CustomCategoriesSection(
            selectedIndex: _selectedCategoryIndex,
            onCategoryTap: _onCategoryTap,
          ),
          const SizedBox(height: 20),
          const CustomPromoSlider(),
          const SizedBox(height: 20),

          // ===== Products Section (hidden until a category is tapped) =====
          if (_showProducts) ...[
            // Section header with selected category badge
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    _buildSectionHeader(),
                    const SizedBox(height: 12),
                    // API Products
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
                                  Icon(Icons.error_outline,
                                      color: Colors.red, size: 32),
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
                                      context
                                          .read<GetProductsCubit>()
                                          .getProducts();
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
                            return _buildEmptyState();
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
                                    right:
                                        index == products.length - 1 ? 4 : 0,
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                          reviews:
                              recommendedProducts[index]['reviews'] as String,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            // ===== Placeholder when no category is selected =====
            _buildSelectCategoryPrompt(),
          ],
        ],
      ),
    );
  }

  /// Builds the section header showing the selected category name with a badge
  Widget _buildSectionHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFF83758), Color(0xFFFC5C7D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF83758).withOpacity(0.35),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.local_offer_rounded,
                  color: Colors.white, size: 16),
              const SizedBox(width: 6),
              Text(
                _selectedCategoryName,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Products',
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            height: 22 / 18,
            letterSpacing: 0,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        // Close / collapse button
        GestureDetector(
          onTap: () => _onCategoryTap(_selectedCategoryIndex),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.keyboard_arrow_up_rounded,
              color: Colors.black54,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  /// Placeholder prompting the user to select a category
  Widget _buildSelectCategoryPrompt() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade50,
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.loginbtn.withOpacity(0.08),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Icon(
              Icons.touch_app_rounded,
              size: 36,
              color: AppColors.loginbtn.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Choose a Category',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap on a category above to explore products',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Colors.grey.shade500,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  /// Empty state when the API returns no products
  Widget _buildEmptyState() {
    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined,
                size: 40, color: Colors.grey.shade400),
            const SizedBox(height: 8),
            Text(
              'No products available',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
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
                            const Icon(Icons.broken_image,
                                size: 60, color: Colors.grey),
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
                            const Icon(Icons.star,
                                color: Colors.amber, size: 14),
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
