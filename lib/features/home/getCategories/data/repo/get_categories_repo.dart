import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_shop/core/network/api_helper.dart';
import 'package:ecommerce_shop/core/network/end_points.dart';

class GetCategoriesRepo {
  // Singleton
  GetCategoriesRepo._internal();
  static final GetCategoriesRepo _instance = GetCategoriesRepo._internal();
  factory GetCategoriesRepo() => _instance;

  final ApiHelper apiHelper = ApiHelper();

  Future<Either<String, List<dynamic>>> getCategories() async {
    try {
      final response = await apiHelper.getRequest(
        endPoint: EndPoints.getCategories,
        isProtected: true,
        isFormData: false,
      );

      if (response.status) {
        final List<dynamic> categories = response.data;
        return Right(categories);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      if (e is DioException &&
          e.response != null &&
          e.response?.data['message'] != null) {
        return Left(e.response?.data['message']);
      }

      print('GetCategories Error: $e');
      return Left(e.toString());
    }
  }
}
