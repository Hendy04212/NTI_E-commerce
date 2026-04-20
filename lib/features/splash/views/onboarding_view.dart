import 'package:ecommerce_shop/core/helper/my_navigator.dart';
import 'package:ecommerce_shop/core/utils/app_assets.dart';
import 'package:ecommerce_shop/features/splash/views/get_started.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:ecommerce_shop/features/splash/manager/cubit/onboarding/onboarding_cubit.dart';

class OnBoardingview extends StatefulWidget {
  const OnBoardingview({super.key});

  @override
  OnBoardingviewState createState() => OnBoardingviewState();
}

class OnBoardingviewState extends State<OnBoardingview> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context) {
    // استدعاء cubit لحفظ الحالة
    context.read<OnboardingCubit>().completeOnboarding();
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return SvgPicture.asset(assetName, width: width);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingCompleted) {
          // الانتقال إلى الشاشة التالية
          MyNavigator.goTo(screen: const GetStartedView());
        }
      },
      child: Scaffold(
        body: IntroductionScreen(
          key: introKey,
          globalBackgroundColor: Colors.white,
          allowImplicitScrolling: true,
          autoScrollDuration: 3000,
          infiniteAutoScroll: true,
          globalHeader: Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, right: 16),
                child: TextButton(
                  onPressed: () => _onIntroEnd(context),
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Color(0Xff000000)),
                  ),
                ),
              ),
            ),
          ),
          pages: [
            PageViewModel(
              title: "Choose Products",
              body:
                  "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
              image: _buildImage(AppAssets.onboard1),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Make Payment",
              body:
                  "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
              image: _buildImage(AppAssets.onboard2),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Get Your Order",
              body:
                  "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
              image: _buildImage(AppAssets.onboard3),
              decoration: pageDecoration,
            ),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context),
          showSkipButton: false,
          skipOrBackFlex: 0,
          nextFlex: 0,
          showBackButton: true,
          back: const Text('Prev',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Color(0XFFC4C4C4))),
          next: const Text('Next',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Color(0XFFF83758))),
          done: const Text('Get Started',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Color(0XFFF83758))),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            activeColor: Color(0xFF17223B),
            color: Color(0xFF17223B33),
            activeSize: Size(40.0, 8.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
      ),
    );
  }

  PageDecoration get pageDecoration => PageDecoration(
        bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.125,
        ),
      );
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _onBackToIntro(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => OnboardingCubit(),
          child: const OnBoardingview(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("This is the screen after Introduction"),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _onBackToIntro(context),
              child: const Text('Back to Introduction'),
            ),
          ],
        ),
      ),
    );
  }
}