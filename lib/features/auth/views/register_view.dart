import 'package:ecommerce_shop/core/helper/my_navigator.dart';
import 'package:ecommerce_shop/core/helper/my_validator.dart';
import 'package:ecommerce_shop/core/translation/translation_keys.dart';
import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/core/utils/app_text_styles.dart';
import 'package:ecommerce_shop/core/widgets/custom_btn.dart';
import 'package:ecommerce_shop/core/widgets/custom_form_field.dart';
import 'package:ecommerce_shop/features/auth/manager/register_cubit/cubit/register_cubit.dart';
import 'package:ecommerce_shop/features/auth/manager/register_cubit/cubit/register_state.dart';
import 'package:ecommerce_shop/features/auth/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration Successful!')),
            );
            MyNavigator.goTo(screen: LoginView());
          } else if (state is RegisterErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          final cubit = RegisterCubit.get(context);
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
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 24.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              TranslationKeys.createAccount,
                              style: AppTextStyle.loginTitel,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomFormField(
                          hintText: TranslationKeys.fullName.tr,
                          prefixIcon: SvgPicture.asset(
                            AppAssets.user,
                            fit: BoxFit.scaleDown,
                          ),
                          controller: cubit.userName,
                          validator: requiredValidator,
                        ),
                        const SizedBox(height: 20),
                        CustomFormField(
                          hintText: TranslationKeys.phone.tr,
                          prefixIcon: SvgPicture.asset(
                            AppAssets.call,
                            fit: BoxFit.scaleDown,
                          ),
                          controller: cubit.phone,
                          validator: phoneValidator,
                        ),
                        const SizedBox(height: 20),
                        CustomFormField(
                          hintText: TranslationKeys.email.tr,
                          prefixIcon: SvgPicture.asset(
                            AppAssets.email,
                            fit: BoxFit.scaleDown,
                          ),
                          controller: cubit.emailController,
                          validator: emailValidator,
                        ),
                        const SizedBox(height: 20),
                        CustomFormField(
                          hintText: TranslationKeys.password.tr,
                          prefixIcon: SvgPicture.asset(
                            AppAssets.lock,
                            fit: BoxFit.scaleDown,
                          ),
                          suffixIcon: Icon(
                            cubit.showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onSuffixIconPressed:
                              () => cubit.changePasswordVisibility(),
                          controller: cubit.passwordController,
                          validator: passwordValidator,
                          obscureText: !cubit.showPassword,
                        ),
                        const SizedBox(height: 20),
                        CustomFormField(
                          hintText: TranslationKeys.confirmPassword.tr,
                          prefixIcon: SvgPicture.asset(
                            AppAssets.lock,
                            fit: BoxFit.scaleDown,
                          ),
                          suffixIcon: Icon(
                            cubit.showConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onSuffixIconPressed:
                              () => cubit.changeConfirmPasswordVisibility(),
                          controller: cubit.passwordConfirmController,
                          validator:
                              (value) => passwordValidator(
                                value,
                                confirm: cubit.passwordController.text,
                              ),
                          obscureText: !cubit.showConfirmPassword,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          TranslationKeys.agreeTerms.tr,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 40),
                        state is RegisterLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : CustomBtn(
                              onPressed: () => cubit.onRegisterPressed(),
                              text: TranslationKeys.register.tr,
                            ),
                        const SizedBox(height: 70),
                      ],
                    ),
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
