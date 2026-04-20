import 'package:bloc/bloc.dart';
import 'package:ecommerce_shop/core/cache/cache_helper.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  void completeOnboarding() async {
    await CacheHelper.saveData(key: 'onboarding_completed', value: true);
    emit(OnboardingCompleted());
  }
}
