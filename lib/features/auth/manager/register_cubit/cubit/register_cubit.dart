import 'package:ecommerce_shop/features/auth/data/repo/auth_repo.dart';
import 'package:ecommerce_shop/features/auth/manager/register_cubit/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  AuthRepo authRepo = AuthRepo();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phone = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  XFile? image;
  bool showPassword = false;
  bool showConfirmPassword = false;

  void changePasswordVisibility() {
    showPassword = !showPassword;
    emit(RegisterChangePassState());
  }

  void changeConfirmPasswordVisibility() {
    showConfirmPassword = !showConfirmPassword;
    emit(RegisterChangePassState());
  }

  void onRegisterPressed() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      if (passwordController.text != passwordConfirmController.text) {
        emit(RegisterErrorState('Passwords do not match'));
        return;
      }

      emit(RegisterLoadingState());
      try {
        var result = await authRepo.register(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          image: image,
          username: userName.text.trim(),
          phone: phone.text.trim(),
        );

        result.fold(
          (String error) {
            emit(RegisterErrorState(error));
          },
          (r) {
            emit(RegisterSuccessState());
          },
        );
      } catch (e) {
        emit(RegisterErrorState('Registration failed. Please try again.'));
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    userName.dispose();
    phone.dispose();
    return super.close();
  }
}
