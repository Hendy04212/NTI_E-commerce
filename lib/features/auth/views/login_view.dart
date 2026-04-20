import 'package:ecommerce_shop/core/helper/my_validator.dart';
import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:ecommerce_shop/core/widgets/custom_btn.dart';
import 'package:ecommerce_shop/core/widgets/custom_form_field.dart';
import 'package:ecommerce_shop/features/auth/manager/login_cubit/cubit/login_cubit.dart';
import 'package:ecommerce_shop/features/auth/manager/login_cubit/cubit/login_state.dart';
import 'package:ecommerce_shop/core/translation/translation_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ecommerce_shop/core/helper/my_navigator.dart';
import 'package:ecommerce_shop/features/home/views/home_view.dart';
import 'package:ecommerce_shop/features/home/manager/cubit/user_cubit/user_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (_) => UserCubit()),
        BlocProvider<LoginCubit>(create: (_) => LoginCubit()),
      ],
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            // Optionally show a loading indicator
          } else if (state is LoginSuccessState) {
            // Store user data in UserCubit and navigate to HomeView
            UserCubit.get(context).getUserData(user: state.userModel);
            MyNavigator.goTo(screen: const HomeView(), isReplace: true);
          } else if (state is LoginErrorState) {
            // Show error message
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  AppAssets.arrowback,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: LoginCubit.get(context).formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            TranslationKeys.welcomeBack.tr,
                            style: AppTextStyle.loginTitel,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomFormField(
                        hintText: TranslationKeys.email.tr,
                        prefixIcon: SvgPicture.asset(
                          AppAssets.email,
                          fit: BoxFit.scaleDown,
                        ),
                        controller: LoginCubit.get(context).emailController,
                        validator: emailValidator,
                      ),
                      SizedBox(height: 20),
                      CustomFormField(
                        obscureText: true,

                        hintText: TranslationKeys.password.tr,
                        prefixIcon: SvgPicture.asset(
                          AppAssets.lock,
                          fit: BoxFit.scaleDown,
                        ),
                        suffixIcon: SvgPicture.asset(
                          AppAssets.eye,
                          fit: BoxFit.scaleDown,
                        ),
                        controller: LoginCubit.get(context).passwordController,
                        validator: passwordValidator,
                      ),
                      SizedBox(height: 40),
                      state is LoginLoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : CustomBtn(
                            text: TranslationKeys.login.tr,
                            onPressed: () {
                              LoginCubit.get(context).onLoginPressed();
                            },
                          ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
