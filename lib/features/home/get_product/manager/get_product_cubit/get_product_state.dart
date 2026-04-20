abstract class GetProductsState {}

class GetProductsInitial extends GetProductsState {}

class GetProductsLoading extends GetProductsState {}

class GetProductsSuccess extends GetProductsState {
  final List<dynamic> products;

  GetProductsSuccess(this.products);
}

class GetProductsError extends GetProductsState {
  final String error;

  GetProductsError(this.error);
}
