import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_shop/core/network/api_response.dart';
import 'package:ecommerce_shop/features/home/data/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/cache/cache_keys.dart';
import '../../../../core/network/api_helper.dart';
import '../../../../core/network/end_points.dart';

class AuthRepo {
  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, void>> register({
    required String username,
    required String password,
    XFile? image,
    required String email,
    required String phone,
  }) async {
    try {
      final response = await apiHelper.postRequest(
        endPoint: EndPoints.register,
        data: {
          'name': username, // ✅ تم تعديل 'username' إلى 'name'
          'password': password,
          'email': email,
          'phone': phone,
          if (image != null)
            'image': await MultipartFile.fromFile(image.path, filename: image.name),
        },
        isFormData: true,
      );

      if (response.status) {
        return Right(null);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      if (e is DioException) {
        final responseData = e.response?.data;
        if (responseData is Map<String, dynamic> && responseData['message'] != null) {
          return Left(responseData['message']);
        }
      }
      return Left('Registration failed. Please try again.');
    }
  }

 Future<Either<String, UserModel>> login({
  required String email,
  required String password,
}) async {
  try {
    final ApiResponse response = await apiHelper.postRequest(
      endPoint: EndPoints.login,
      data: {
        'email': email,
        'password': password,
      },
    );

    print("Response data: ${response.data}");

    if (response.status) {
      final loginResponseModel = LoginResponseModel.fromJson(response.data);

      await CacheHelper.saveData(key: CacheKeys.accessToken, value: loginResponseModel.accessToken);
      await CacheHelper.saveData(key: CacheKeys.refreshToken, value: loginResponseModel.refreshToken);

      if (loginResponseModel.user != null) {
        return Right(loginResponseModel.user!);
      } else {
        return Left("User data is missing");
      }
    } else {
      return Left(response.message);
    }
  } catch (e, stackTrace) {
    print("Login Error: $e");
    print(stackTrace);
    return Left("Login failed. Please try again.");
  }
}


}