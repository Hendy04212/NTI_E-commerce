abstract class GetCategoriesState {}

class GetCategoriesInitial extends GetCategoriesState {}

class GetCategoriesLoading extends GetCategoriesState {}

class GetCategoriesSuccess extends GetCategoriesState {
  final List<dynamic> categories;

  GetCategoriesSuccess(this.categories);
}

class GetCategoriesFailure extends GetCategoriesState {
  final String error;

  GetCategoriesFailure(this.error);
}
