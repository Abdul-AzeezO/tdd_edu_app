import 'package:education_app/core/common/views/under_construction_view.dart';
import 'package:education_app/core/services/dependency_injection/injection.dart';
import 'package:education_app/src/onboarding/view/cubit/onboarding_cubit.dart';
import 'package:education_app/src/onboarding/view/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnboardingView.routeName:
      return _viewBuilder(
        (_) => BlocProvider(
          create: (_) => getIt<OnboardingCubit>(),
          child: const OnboardingView(),
        ),
        routeSettings: settings,
      );
    default:
      return _viewBuilder(
        (_) => const UnderConstructionView(),
        routeSettings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _viewBuilder(
  Widget Function(BuildContext) view, {
  required RouteSettings routeSettings,
}) =>
    PageRouteBuilder(
      settings: routeSettings,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      pageBuilder: (context, _, __) => view(context),
    );
