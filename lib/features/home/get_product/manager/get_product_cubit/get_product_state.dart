import 'package:ecommerce_shop/features/home/get_product/data/repo/get_product_repo.dart';

abstract class GetProductsState {}

class GetProductsInitial extends GetProductsState {}

class GetProductsLoading extends GetProductsState {}

class GetProductsSuccess extends GetProductsState {
  final List<Product> products;

  GetProductsSuccess(this.products);
}

class GetProductsError extends GetProductsState {
  final String error;

  GetProductsError(this.error);
}
