import 'package:bloc/bloc.dart';
import 'package:ecommerce_shop/features/home/getCategories/data/repo/get_categories_repo.dart';
import 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesCubit() : super(GetCategoriesInitial());

  final GetCategoriesRepo _repo = GetCategoriesRepo();

  Future<void> getCategories() async {
    emit(GetCategoriesLoading());

    final result = await _repo.getCategories();

    result.fold(
      (error) => emit(GetCategoriesFailure(error)),
      (categories) => emit(GetCategoriesSuccess(categories)),
    );
  }
}
