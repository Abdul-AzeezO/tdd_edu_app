import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/res/assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UnderConstructionView extends StatelessWidget {
  const UnderConstructionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        image: Assets.images.onBoardingBackgroundPNG,
        child: Center(
          child: LottieBuilder.asset(Assets.lottie.pageUnderConstructionJSON),
        ),
      ),
    );
  }
}
