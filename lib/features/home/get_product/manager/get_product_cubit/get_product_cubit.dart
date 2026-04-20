
import 'package:ecommerce_shop/features/home/get_product/data/repo/get_product_repo.dart';
import 'package:ecommerce_shop/features/home/get_product/manager/get_product_cubit/get_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit(this.repo) : super(GetProductsInitial());

  final GetProductsRepo repo;

  Future<void> getProducts() async {
    emit(GetProductsLoading());
    try {
      final products = await repo.getProducts();
      emit(GetProductsSuccess(products));
    } catch (e) {
      emit(GetProductsError(e.toString()));
    }
  }
}
